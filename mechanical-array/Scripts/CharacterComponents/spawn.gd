extends Node2D

@export var point1: Vector2 = Vector2(50,50)
@export var point2: Vector2 = Vector2(1100,600)

@onready var player: Resource = preload("res://Scenes/Mechs/gunner_mech.tscn")

func get_random_point_inside(p1: Vector2, p2: Vector2) -> Vector2:
	var x_value: float = randf_range(p1.x, p2.x)
	var y_value: float = randf_range(p1.y, p2.y)
	var random_point_inside: Vector2 = Vector2(x_value, y_value)
	return(random_point_inside)

func spawn_player():
	var player_instance: Node = player.instantiate()
	add_child(player_instance)
	var spawn_location: Vector2 = get_random_point_inside(point1, point2)
	player_instance.set_position(spawn_location)

func _ready() -> void:
	randomize()

func _process(_delta: float) -> void:
	if is_instance_valid(player) == false:
		spawn_player()
