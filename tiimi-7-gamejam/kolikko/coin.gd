extends Area2D

func _ready():
	body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	if body.name == "pelaaja":
		body.add_score(1)
		body.play_coin_sound()  
		queue_free()
