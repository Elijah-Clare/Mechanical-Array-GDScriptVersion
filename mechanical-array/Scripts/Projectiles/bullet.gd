extends Node2D

@export var SPEED : int = 600
@export var damage : int = 9
@export var random_rot_range : float = 3.0

var velocity
var mech_damage_particles

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()

#Bullet moves at speed * delta towards whatever direction it is facing
#Ben coded this

func _ready():
	mech_damage_particles = get_node("MechDamageParticles")
	rotation_degrees += randf_range(-random_rot_range, random_rot_range)
	velocity = Vector2()
	velocity.x = SPEED * cos(rotation)
	velocity.y = SPEED * sin(rotation)


func _physics_process(delta):
	position += velocity * delta


func _on_Bullet_body_entered(body):
	#if entering mech
	if body.is_in_group("player"):
		activate_mech_collision_particles()
		#var health_component = body.get_node_or_null("HealthComponent")
		#if health_component:
			#health_component.take_damage(damage)
		queue_free()
	#if entering environment object
	elif body is StaticBody2D:
		queue_free()

func activate_mech_collision_particles():
	# Reparent these particles so they don't get deleted with the bullet
	mech_damage_particles.reparent(get_tree().current_scene, true)
	# Play the particles
	mech_damage_particles.activate()
