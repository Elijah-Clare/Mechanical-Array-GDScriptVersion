extends Node2D

@onready var particles = $Particles
@onready var sound_effects = $SoundEffects

@export var pitch_scale_range : float = 0.1

func activate():
	for particle in particles.get_children():
		particle.emitting = true
	
	var sfx = sound_effects.get_children().pick_random()
	sfx.pitch = 1.0 + randf_range(-pitch_scale_range, pitch_scale_range)
	sfx.play()
