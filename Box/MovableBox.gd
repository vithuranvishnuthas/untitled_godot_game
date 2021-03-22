extends KinematicBody2D

var velocity = Vector2.ZERO

func _physics_process(delta):
	var collision = move_and_collide(delta * velocity)
	if collision:
		velocity = collision.normal * 100
	else:
		velocity = Vector2.ZERO if velocity <= Vector2.ZERO else velocity - velocity/10
