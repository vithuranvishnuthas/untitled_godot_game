extends KinematicBody2D

onready var timer = $Timer
onready var sprite = $Sprite

const MAX_HP = 30

var weapon := preload("res://Attack/Turret_Missile.tres")

var target: KinematicBody2D
var current_hp := MAX_HP

func _ready():
	timer.start(weapon.attack_speed)

func _physics_process(delta):
	rotate_to_player()

func attack():
	if target:
		var attack_scene := load("res://Attack/Attack.tscn")
		var attack = attack_scene.instance()
		attack.change_weapon(weapon)
		attack.exclude_attacker_collision(collision_layer)
		
		var attack_distance_to_turret = sprite.texture.get_size().x / 1.5
		var attack_velocity = position.direction_to(target.position).normalized()
	
		attack.position_projectile(position, attack_velocity, attack_distance_to_turret, rotation/2)
		attack.velocity = attack_velocity
		attack.targets += ["Player"]
		get_tree().get_root().add_child(attack)
	
func _on_Timer_timeout():
	attack()

func rotate_to_player():
	if target: 
		var angle = get_angle_to(target.position)
		var max_speed = 0.08
		rotation += max(-max_speed, angle) if angle < 0 else min(max_speed, angle)

func reduce_hp(value: int):
	self.current_hp -= value
	print("Turrent HP:", current_hp)
	check_death()
	
func check_death():
	if current_hp <= 0: queue_free()

func _on_PlayerDetection_body_entered(body):
	if body.name == "Player": target = body

func _on_PlayerDetection_body_exited(body):
	if target && body.name == target.name:
		target = null
