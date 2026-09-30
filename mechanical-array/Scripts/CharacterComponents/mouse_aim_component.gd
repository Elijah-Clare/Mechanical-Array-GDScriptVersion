extends Node2D

var BULLET = preload("res://Scenes/Projectiles/bullet.tscn")

func _process(delta: float) -> void:
	look_at(get_global_mouse_position())
	global_position = $"../GunnerMech".global_position
	
	if Input.is_action_just_pressed("shoot"):
		var bullet_instance = BULLET.instantiate()
		get_tree().root.add_child(bullet_instance)
		bullet_instance.global_position = global_position
		bullet_instance.rotation = rotation
		print("bullet direction: " + str(bullet_instance.rotation_degrees))
		print("mech direction: " + str($"..".rotation_degrees))
		
