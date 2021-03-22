extends StaticBody2D

onready var animation = $AnimationPlayer
var is_open := false

	
func open():
	animation.play("Open")
	is_open = true
	
func close():
	animation.play_backwards("Open")
	is_open = false
