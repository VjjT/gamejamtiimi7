extends Area2D

func _ready():
	body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	if body.is_in_group("player") and body.velocity.y > 10:
		get_parent().die()

		# Pomputa pelaaja ylös
		body.velocity.y = -320.0
