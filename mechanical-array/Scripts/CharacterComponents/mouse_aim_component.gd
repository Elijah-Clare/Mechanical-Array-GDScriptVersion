extends Node2D


@export var sprite_to_rotate : Node2D
@export var rotation_speed : float

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	sprite_to_rotate.rotation = lerp_angle(rotation, rotation + get_angle_to(get_global_mouse_position()), rotation_speed * delta)
