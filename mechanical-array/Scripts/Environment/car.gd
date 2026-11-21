extends Node2D



@export var car_sprites : Array[CompressedTexture2D]

var healthcomponent : Node
var sprite : Sprite2D

#func _ready() -> void:
	#$HealthComponent.died.connect(on_died)

func on_died() -> void: queue_free()

func _on_health_component_died() -> void:
	queue_free()


#Randomly sets car sprite and visibility
#Ben coded this


func _ready():
	
	healthcomponent = get_node_or_null("HealthComponent")
	if healthcomponent:
		healthcomponent.died.connect(on_died)
	else:
		printerr("Car could not find HealthComponent.")
	
	var visibility_chance = randi_range(1,2)
	if visibility_chance == 1:
		visible = false
	else:
		sprite = get_node("Sprite2D")
		sprite.texture = car_sprites.pick_random()
