extends StaticBody2D

func _ready() -> void:
	$HealthComponent.died.connect(on_died)

func on_died() -> void: queue_free()

func _process(_delta: float) -> void:
	pass


func _on_health_component_died() -> void:
	queue_free()
