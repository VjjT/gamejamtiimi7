extends CharacterBody2D

const SPEED = 80
var direction = 1
@export var move_distance: float = 50
@export var damage_amount: int = 1
var start_x: float
var is_dead = false

@onready var death_sound = $AudioStreamPlayer2D

func _ready():
	start_x = position.x

func _physics_process(_delta):
	if is_dead:
		return
	velocity.x = SPEED * direction
	move_and_slide()
	if position.x < start_x - move_distance:
		direction = 1
	elif position.x > start_x + move_distance:
		direction = -1

func die():
	if is_dead:
		return
	is_dead = true
	death_sound.play()
	await death_sound.finished
	queue_free()

func _on_damage_body_entered(body):
	if body.has_method("take_damage"):
		body.take_damage(damage_amount)

func _on_hurtbox_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") and body.velocity.y > 10:
		die()
		body.velocity.y = -320.0
