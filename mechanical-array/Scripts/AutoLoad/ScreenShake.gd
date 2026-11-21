extends Node


var funcault_shake_strength : float = 2.0
var max_shake_strength : float = 8.0
var fade_speed : float = 10.0
	
var shake_strength : float = 0.0
var camera_to_shake : Camera2D = null
	
func shake(camera_number, shake_amount = funcault_shake_strength):
	var camera_list = get_tree().get_nodes_in_group("cameras")
	for camera in camera_list:
		if camera.camera_number == camera_number:
			camera_to_shake = camera
			shake_strength = shake_amount


func _process(delta):
	
	if shake_strength > max_shake_strength:
		shake_strength = max_shake_strength
	
	if shake_strength > 0.0 and camera_to_shake:
		shake_strength = lerp(shake_strength, 0.0, fade_speed * delta)
		
		camera_to_shake.offset = Vector2.ZERO + random_offset()

func random_offset():
	return Vector2(randf_range(-shake_strength, shake_strength), randf_range(-shake_strength, shake_strength))

#Python does not have lerp so i copied how godot does it for a helper function
func lerp(from_val, to_val, weight):
		return from_val + (to_val - from_val) * weight
