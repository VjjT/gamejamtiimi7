extends Area2D

@onready var maali_aani = $AudioStreamPlayer2D



func _on_body_entered(body):
	if body.name == "pelaaja":
		maali_aani.play()
		await maali_aani.finished
		get_tree().reload_current_scene()
