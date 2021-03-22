extends Area2D

export(int) var value = 5

func _on_HealthBoost_body_entered(body):
	if body.name == "Player":
		body.heal(value)
		queue_free()
