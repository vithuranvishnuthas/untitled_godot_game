extends KinematicBody2D

onready var collision_shape = $CollisionShape2D

var velocity := Vector2.UP
export var speed := 100.0

func _ready():
	velocity = velocity.rotated(rotation)
	collision_shape.position = collision_shape.position.rotated(rotation)

func _physics_process(delta):
	var collision = move_and_collide(velocity * delta * speed)
	if collision && collision.collider.name == "Player":
		collision.collider.knockback(300, 0.2)

func _on_Scanner_body_entered(body):
	if body.name == "Player":
		body.knockback(300, 0.2)
	else:
		rotate(deg2rad(180))
		velocity = -velocity
		collision_shape.position = -collision_shape.position
	
