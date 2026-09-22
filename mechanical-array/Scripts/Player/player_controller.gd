'''
Player Controller Overview:
	The player controller handles player input, mech possession, and logic that
	has to do with the player state. It communicates with other nodes in order to
	isolate logic and make the code more modular and less spaghetti. For example,
	it gets direction by reading keyboard input and changes the possessed mech
	direction.
'''

extends Node

# Player info
@export var player_number: int = -1
@export var device: int = -1
@export var team: int = -1
# Deadzones
@export var gamepad_deadzone: float = 0.25
@export var mouse_look_deadzone: float = 10.0

# Possessed mech and states
var possessed_mech: Node2D
var move_direction: Vector2
# Mouse stuff
var mouse_moving: bool = false
var mouse_look_direction = 0
# Camera stuff
var camera_target: Node
var camera: Camera2D
# Components
var movement_component: Node
var health_component: Node
var shoot_component: Node
var look_component: Node

# Runs on node initialization
func _ready() -> void:
	# The mech the player starts with, can be set to None if player is in
	# GUI so that the mech doesnt move on pause screen, etc.
	possessed_mech = get_child(0)
	
	# Setting up components
	movement_component = possessed_mech.get_node("MovementComponent")
	health_component = possessed_mech.get_node("HealthComponent")
	shoot_component = possessed_mech.get_node("ShootComponent")
	look_component = possessed_mech.get_node("LookComponent")
	camera_target = possessed_mech.get_node("TopPivot/CameraTarget")
	
	# Initialize player health
	health_component.respawn()
	
	if self.device == -1:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

# Assigns player number to each related component
func assign_player_number():
	movement_component.player_number = player_number
	health_component.player_number = player_number
	shoot_component.player_number = player_number
	look_component.player_number = player_number

func set_camera(new_camera):
	camera = new_camera

# Runs between frames
func _process(_delta):
	# Only send movement input if mech is active
	if possessed_mech:
		move()
		look()
		shoot()
	
	if camera:
		camera.set_camera_position(camera_target.global_position)

# Sends movement input to mech node
func move():
	if self.device == -1:
		move_direction = get_keyboard_direction()
	else:
		move_direction = get_gamepad_move_direction()
	if movement_component:
		movement_component.set("input_direction", move_direction)

# Sends mouse position to mech node
func look():
	if device == -1 and mouse_moving == true:
		look_component.set("mouse_look_rotation", mouse_look_direction)
		mouse_moving = false
	elif self.get_gamepad_look_direction():
		look_component.set("gamepad_look_mode", true)
		look_component.set("gamepad_look_rotation", get_gamepad_look_direction())

# Send signal to shoot to mech node
func shoot():
	if device == -1:
		if Input.is_action_pressed("keyboard_fire"):
			if shoot_component:
				shoot_component.set("shooting", true)
	else:
		if Input.is_joy_button_pressed(device, 7 as JoyButton):
			if shoot_component:
				shoot_component.set("shooting", true)

func get_keyboard_direction() -> Vector2:
	var direction = Vector2()
	if Input.is_action_pressed("keyboard_right"):
		direction.x += 1
	if Input.is_action_pressed("keyboard_left"):
		direction.x -= 1
	if Input.is_action_pressed("keyboard_down"):
		direction.y += 1
	if Input.is_action_pressed("keyboard_up"):
		direction.y -= 1
	return direction

func get_gamepad_move_direction() -> Vector2:
	var direction = Vector2()
	direction.x = Input.get_joy_axis(device, 0 as JoyAxis)
	direction.y = Input.get_joy_axis(device, 1 as JoyAxis)
	
	if direction.length() < gamepad_deadzone:
		return Vector2()
	
	return direction
	
func get_gamepad_look_direction():
	var direction = Vector2()
	direction.x = Input.get_joy_axis(device, 2 as JoyAxis)
	direction.y = Input.get_joy_axis(device, 3 as JoyAxis)
	
	if direction.length() < gamepad_deadzone:
		return
	
	return direction.angle()

# For mouse look movement
func _input(event):
	# If it is mouse motion event and this player uses keyboard
	if is_instance_of(event, InputEventMouseMotion) and device == -1:
		# Check relative, which is mouse position relative to last frame, for direction
		var new_direction = event.relative
		# If its greater than the deadzone, set it
		if new_direction.length() > mouse_look_deadzone:
			mouse_look_direction = new_direction.angle()
			mouse_moving = true
