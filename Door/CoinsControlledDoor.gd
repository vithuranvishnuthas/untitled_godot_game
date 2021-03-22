extends Node2D

onready var door = $Door
onready var switch = $Switch

export(int) var costs = 50

func _on_Switch_body_entered(body):
	if body.name == "Player":
		if body.coins >= costs:
			body.coins = max(body.coins - costs, 0)
			door.open()
			switch.queue_free()
