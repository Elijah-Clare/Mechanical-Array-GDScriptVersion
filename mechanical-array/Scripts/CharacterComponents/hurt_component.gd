class_name HurtboxComponent
extends Area2D

@export var health_component: HealthComponent

func take_hit(attack: int):
	if health_component:
		health_component.damage(attack)
		$"../Camera2D".screen_shake(8, 0.5)

func _ready() -> void:
	pass 

func _process(_delta: float) -> void:
	pass
