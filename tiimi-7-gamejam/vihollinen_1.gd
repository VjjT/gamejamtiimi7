extends CharacterBody2D

const SPEED = 80
var direction = 1

func _process(delta):
	position.x += SPEED * direction * delta
