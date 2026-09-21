extends Node

@export var character : CharacterBody2D
@export var animation_player : AnimationPlayer

@export var speed = 150
@export var rotation_speed = 1.5
@export var animations_enabled = true

var rotation_direction = 0

func get_input():
	if animations_enabled == true:
		if Input.is_action_pressed("move_forward"):
			animation_player.play()
		elif Input.is_action_pressed("move_backward"):
			animation_player.play_backwards()
		else:
			animation_player.pause()
	
	rotation_direction = Input.get_axis("turn_left", "turn_right")
	character.velocity = character.transform.x * Input.get_axis("move_backward", "move_forward") * speed

func _physics_process(delta):
	get_input()
	character.rotation += rotation_direction * rotation_speed * delta
	character.move_and_slide()
