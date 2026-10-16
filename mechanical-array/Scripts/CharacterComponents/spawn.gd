extends Node2D

@export var mech_scene: PackedScene = preload("res://Scenes/Mechs/gunner_mech.tscn")
@export var spawn_area := Rect2(50, 50, 1050, 550)
@export var respawn_delay := 1.0

var current_mech: Node2D

func _ready() -> void:
	randomize()
	spawn_player()

func get_random_point_inside(area: Rect2) -> Vector2:
	return Vector2(
		randf_range(area.position.x, area.end.x),
		randf_range(area.position.y, area.end.y)
	)

func spawn_player() -> void:
	current_mech = mech_scene.instantiate()
	add_child(current_mech)
	current_mech.global_position = get_random_point_inside(spawn_area)
	current_mech.get_node("GunnerMech/HealthComponent").died.connect(_on_mech_died)

func _on_mech_died() -> void:
	if current_mech.is_queued_for_deletion():
		return
	current_mech.queue_free()
	await get_tree().create_timer(respawn_delay).timeout
	spawn_player()
