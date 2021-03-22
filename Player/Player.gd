extends KinematicBody2D

onready var sprite = $Sprite
onready var collision_polygon = $CollisionPolygon2D
onready var attack_timer = $AttackTimer

const MAX_HP = 100

export(float) var speed = 100.0
export(float) var defense = 10.0

var velocity := Vector2.ZERO
var current_hp = MAX_HP
var direction := Vector2.UP
var knockback := false
var attack_enabled := true
var knockback_amplifier := 200
var weapon := load("res://Attack/Beginner.tres")
var coins := 0

func _physics_process(delta):
	# move player based on input
	if knockback:
		velocity = -direction * 300
	else:
		player_movement()
	var _collision = move_and_collide(velocity * delta)

func player_movement():
	# new direction
	var velocity_direction = Vector2.ZERO
		
	# based on input change direction, rotate player 
	if Input.is_action_pressed("ui_up"):
		sprite.rotation_degrees = 0.0
		collision_polygon.rotation_degrees = 0.0
		direction = Vector2.UP
		velocity_direction = direction
	if Input.is_action_pressed("ui_right"):
		sprite.rotation_degrees = 90.0
		collision_polygon.rotation_degrees = 90.0
		direction = Vector2.RIGHT
		velocity_direction = direction
	if Input.is_action_pressed("ui_down"):
		sprite.rotation_degrees = 180.0
		collision_polygon.rotation_degrees = 180.0
		direction = Vector2.DOWN
		velocity_direction = direction
	if Input.is_action_pressed("ui_left"):
		sprite.rotation_degrees = 270.0
		collision_polygon.rotation_degrees = 270.0
		direction = Vector2.LEFT
		velocity_direction = direction
	
	# attack
	if Input.is_action_just_pressed("attack") && attack_enabled == true:
		attack()
		
	# new velocity 
	velocity = velocity_direction * speed


func attack():
	# load instance of attack projectile
	var attack_scene := load("res://Attack/Attack.tscn")
	var attack = attack_scene.instance()
	
	attack.change_weapon(self.weapon)
	
	attack.exclude_attacker_collision(collision_layer)
	
	# projectile distance to player
	var attack_distance_to_player = sprite.texture.get_size().x / 1.5
	
	# append hittable targets
	var attack_targets = ["Seeker", "Turret", "DestructibleBox"]
	attack.targets += attack_targets
	# position projectile in front of player at start
	attack.position_projectile(self.position, direction, attack_distance_to_player, deg2rad(sprite.rotation_degrees))
	# set attack velocity (without speed amplifier) to player's direction
	attack.velocity = direction
	# add this instance of attack
	disable_attack(attack.attack_speed)
	get_tree().get_root().add_child(attack)
	
func disable_attack(attack_speed: float):
	attack_enabled = false
	attack_timer.start(attack_speed)

func increase_speed(value: float):
	self.speed += value
	
func decrease_speed(value: float):
	self.speed -= value
	
func reduce_hp(value: int):
	self.current_hp -= max(0, value - self.defense)
	print(current_hp)
	check_death()
	
func heal(value: int):
	current_hp = min(MAX_HP, current_hp + value)
	print(current_hp)

func check_death():
	if current_hp <= 0: queue_free()

func knockback(value: int, time: float):
	knockback = true
	knockback_amplifier = value
	yield(get_tree().create_timer(time), "timeout")	
	knockback = false

func collect_coins(value):
	self.coins += value
	print(self.coins)

func _on_AttackTimer_timeout():
	attack_enabled = true
