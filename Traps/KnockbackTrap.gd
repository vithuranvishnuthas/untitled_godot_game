extends Area2D

onready var animation = $AnimatedSprite
export(int) var amplifier := 100

func _ready():
	animation.visible = false

func _on_KnockbackTrap_body_entered(body):
	if body.name == "Player":
		animation.visible = true
		animation.rotation_degrees = 180 + body.sprite.rotation_degrees
		animation.play()
		body.knockback(amplifier, 0.3)

func _on_AnimatedSprite_animation_finished():
	queue_free()
