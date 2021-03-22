extends KinematicBody2D

export(int) var attack_damage = 50
export(float) var speed = 150.0

const MAX_HP = 50

var velocity := Vector2.ZERO
var target: KinematicBody2D 
var current_hp = MAX_HP

func _physics_process(delta):
	seeker_movement()
	var collision = move_and_collide(velocity * speed * delta)
	if collision:
		if collision.collider == target: collision.collider.reduce_hp(attack_damage)
		reduce_hp(attack_damage)
		queue_free()
		
func seeker_movement():
	if target:
		velocity = position.direction_to(target.position).normalized()
	else:
		velocity = Vector2.ZERO

func _on_PlayerDetection_body_entered(body):
	if body.name == "Player":
		target = body
		print(target.name)

func _on_PlayerDetection_body_exited(body):
	if body == target:
		target = null

func reduce_hp(value: int):
	self.current_hp -= value
	check_death()
	
func check_death():
	if self.current_hp <= 0: queue_free()
