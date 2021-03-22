extends Area2D

export(float) var value = 5.0

func _on_SpeedDecrease_body_entered(body):
	if body.name == "Player":
		body.decrease_speed(value)
		queue_free()
