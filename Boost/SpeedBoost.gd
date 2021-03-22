extends Area2D

export(float) var added_speed = 50.0

func _on_SpeedBoost_body_entered(body):
	if body.name == "Player":
		body.increase_speed(added_speed)
		queue_free()
