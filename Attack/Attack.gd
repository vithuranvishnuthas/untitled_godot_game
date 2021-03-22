extends Area2D

onready var sprite := $Sprite
onready var collision_shape := $CollisionShape2D

var moving_speed: float
var attack_damage: int
var attack_speed: float

var velocity := Vector2.ZERO
var targets: Array
var weapon_texture: Texture	
	
func _ready():
	if weapon_texture: sprite.texture = weapon_texture
	collision_shape.shape.extents = sprite.texture.get_size()
	
func exclude_attacker_collision(attacker_collision_layer: int):
	collision_mask -= attacker_collision_layer

func _physics_process(delta):
	position += velocity * moving_speed * delta 
	
func change_weapon(weapon: Weapon):
	self.attack_damage = weapon.damage
	self.moving_speed = weapon.moving_speed
	self.attack_speed = weapon.attack_speed
	self.weapon_texture = weapon.texture

func position_projectile(body_position: Vector2, direction: Vector2, distance: float, body_rotation: float):
	self.position = body_position + direction * distance
	self.rotation = body_rotation

func _on_Attack_body_entered(body):
	if body.name in targets:
		body.reduce_hp(attack_damage)
	queue_free()
