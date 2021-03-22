extends StaticBody2D

onready var sprite = $Sprite
var desired_frame = 0

export(int) var hp = 30

var MAX_HP = hp
	
func reduce_hp(value):
	self.hp -= value
	set_desired_frame()
	if sprite.frame < desired_frame:
		sprite.play()
	check_death()

func set_desired_frame():
	desired_frame = min(int(MAX_HP/max(hp, 1)) - 1, sprite.frames.get_frame_count("default"))

func check_death():
	if self.hp <= 0:
		queue_free()


func _on_Sprite_frame_changed():
	if sprite.frame >= desired_frame:
		sprite.stop()
	
