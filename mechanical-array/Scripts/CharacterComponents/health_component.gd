class_name HealthComponent
extends Node

signal died
signal health_changed(new_amount)

@export var max_health := 100.0
var current_health: float

func _ready() -> void:
	current_health = max_health

func damage(attack: int):
	current_health -= attack
	health_changed.emit(current_health)
	
	if current_health <= 0:
		died.emit()

func _process(delta: float) -> void:
	pass
