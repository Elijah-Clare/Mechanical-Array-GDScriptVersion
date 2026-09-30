class_name HurtboxComponent
extends Area2D

@export var health_component: HealthComponent

func take_hit(attack: int):
	if health_component:
		health_component.damage(attack)

func _ready() -> void:
	pass 

func _process(delta: float) -> void:
	pass
