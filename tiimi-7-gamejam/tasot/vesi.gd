extends Area2D



func _on_body_entered(body):
	if body.name == "pelaaja":
		body.play_water_sound()
		body.die()
	
