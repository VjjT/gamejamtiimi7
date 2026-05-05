extends CharacterBody2D

const SPEED = 80
var direction = 1

@export var move_distance: float = 50
@export var damage_amount: int = 1

var start_x: float

func _ready():
	start_x = position.x

func _physics_process(delta):
	velocity.x = SPEED * direction
	move_and_slide()

	if position.x < start_x - move_distance:
		direction = 1
	elif position.x > start_x + move_distance:
		direction = -1

func die():
	queue_free()
	
func _on_damage_body_entered(body):
	if body.has_method("take_damage"):
		body.take_damage(damage_amount)


func _on_hurtbox_body_entered(body: Node2D) -> void:
	pass # Replace with function body.
