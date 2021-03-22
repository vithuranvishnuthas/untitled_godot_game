extends Node

onready var door = $Door
onready var switch = $Switch
var interacting_body : CollisionObject2D


func _on_Switch_body_entered(body):
	if door.is_open == false: 
		door.open()
		switch.switch_on()
		interacting_body = body

func _on_Switch_body_exited(body):
	if door.is_open && body == interacting_body: 
		door.close()
		switch.switch_off()
