extends CharacterBody2D
@onready var heart = get_node("/root/main/CanvasLayer/heart")
@onready var score_label = get_node("/root/main/CanvasLayer/score_label")
@onready var sprite = $AnimatedSprite2D
var score = 0
var health = 3
var max_health = 3
const SPEED = 200.0
const JUMP_VELOCITY = -300.0
const MAX_JUMPS = 2
var jump_count = 0
var start_position: Vector2

func _ready():
	start_position = global_position
	update_heart()
	update_score()
	add_to_group("player")

func add_score(amount):
	score += amount
	print("Score:", score)
	update_score()

func update_score():
	if score_label == null:
		return
	score_label.text = "Pisteet: " + str(score)

func update_heart():
	if heart == null:
		return
	for i in range(heart.get_child_count()):
		heart.get_child(i).visible = i < health
		
func take_damage(amount: int = 1):
	for i in range(amount):
		die()

func die():
	health -= 1
	update_heart()
	if health <= 0:
		print("GAME OVER")
		get_tree().reload_current_scene()
		return
	global_position = start_position + Vector2(0, -10)
	velocity = Vector2.ZERO
	jump_count = 0

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	else:
		jump_count = 0
	if Input.is_action_just_pressed("ui_accept") and jump_count < MAX_JUMPS:
		velocity.y = JUMP_VELOCITY
		jump_count += 1
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction != 0:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	move_and_slide()
	update_animation(direction)

func update_animation(direction):
	if not is_on_floor():
		sprite.play("jump")
	elif direction != 0:
		sprite.play("move")
	else:
		sprite.play("idle")
	if direction != 0:
		sprite.flip_h = direction < 0
