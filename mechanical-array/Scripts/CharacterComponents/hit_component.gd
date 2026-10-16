class_name HitboxComponent
extends Area2D

@export var attack_damage:= 10.0

func _ready() -> void:
	area_entered.connect(_on_area_entered)

func _on_area_entered(area: Area2D) -> void:
	if area is HurtboxComponent:
		if area.owner == owner:
			return
		area.take_hit(attack_damage)
