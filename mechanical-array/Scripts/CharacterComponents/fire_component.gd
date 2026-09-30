extends Node

@export var player_number: int = 0
@export var rate_of_fire: float = 0.2
var shooting: bool = false

var screen_shake: Node
var bullet: PackedScene
var mech_top: Node
var proj_spawns: Node
var rate_of_fire_timer: Node
var muzzle_flash: Node
var sound_effects: Node

func _ready() -> void:
	screen_shake = get_node("/root/ScreenShake")
	bullet = load("res://Scenes/Projectiles/bullet.tscn")
	mech_top = get_node("../MouseAi/MechHead")
	proj_spawns = mech_top.get_node("ProjectileSpawns")
	rate_of_fire_timer = get_node("RateOfFireTimer")
	muzzle_flash = get_node("MuzzleFlash")
	sound_effects = get_node("SoundEffects")

func _process(_delta: float) -> void:
	if shooting:
		if rate_of_fire_timer.is_stopped():
			rate_of_fire_timer.start(rate_of_fire)
	else:
		rate_of_fire_timer.stop()

func fire() -> void:
	play_sound_effect()
	screen_shake.shake(player_number)
	for node in proj_spawns.get_children():
		var b = bullet.instantiate()
		b.global_position = node.global_position
		b.rotation = mech_top.rotation
		get_tree().get_root().add_child(b)
		show_muzzle_flash(node.global_position, mech_top.rotation)
	shooting = false

func show_muzzle_flash(pos: Vector2, rot: float) -> void:
	muzzle_flash.global_position = pos
	muzzle_flash.rotation = rot
	muzzle_flash.emitting = true

func play_sound_effect() -> void:
	var children = sound_effects.get_children()
	var sound_to_play = children[randi() % children.size()]
	sound_to_play.play()

func _on_RateOfFireTimer_timeout() -> void:
	fire()
