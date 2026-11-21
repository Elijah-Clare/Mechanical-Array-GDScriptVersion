extends Node2D

@onready var gunner_mech = $"../GunnerMech"

var BULLET = preload("res://Scenes/Projectiles/bullet.tscn")

var current_gun : int = 1


func _process(_delta: float) -> void:
	look_at(get_global_mouse_position())
	global_position = gunner_mech.global_position
	
	if Input.is_action_just_pressed("shoot"):
		var bullet_instance = BULLET.instantiate()
		bullet_instance.global_position = $Marker2D.global_position
		bullet_instance.rotation = rotation
		get_tree().root.add_child(bullet_instance)
