extends Area2D

onready var sprite = $Sprite
onready var switch_on_sprite = preload("res://Switch/switch2.png")
onready var switch_off_sprite = preload("res://Switch/switch.png")


func switch_on():
	sprite.texture = switch_on_sprite
	
func switch_off():
	sprite.texture = switch_off_sprite
