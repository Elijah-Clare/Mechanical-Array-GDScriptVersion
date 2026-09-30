class_name HitboxComponent
extends Area2D

@export var attack_damage:= 10.0

func _init():
	area_entered.connect(_on_area_entered)
	
func _on_area_entered(area):
	if area is HurtboxComponent:
		area.take_hit(attack_damage)
		print("Car took dmg")

func _ready() -> void:
	pass 

func _process(delta: float) -> void:
	pass
