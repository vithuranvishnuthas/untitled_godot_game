extends Area2D

onready var sprite = $Sprite
export(float) var slow_value = 50.0  
var triggered := false

func _on_SlowTrap_body_entered(body):
	if body.name == "Player":
		triggered = true
		sprite.visible = true
		body.decrease_speed(slow_value)

func _on_SlowTrap_body_exited(body):
	if body.name == "Player" && triggered:
		queue_free()
