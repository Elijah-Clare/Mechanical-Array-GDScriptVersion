extends ProgressBar

@export var health: HealthComponent

func _ready():
	max_value = health.max_health
	value = health.current_health
	health.health_changed.connect(_on_health_changed)

func _on_health_changed(new_amount: float) -> void:
	value = new_amount
