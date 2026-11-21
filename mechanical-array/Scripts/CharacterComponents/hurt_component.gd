class_name HurtboxComponent
extends Area2D

@export var health_component: HealthComponent

var camera

func _ready() -> void:
	camera = get_node_or_null("../Camera2D")

func take_hit(attack: int):
	if health_component:
		health_component.damage(attack)
		if camera:
			camera.screen_shake(8, 0.5)


func _process(_delta: float) -> void:
	pass
