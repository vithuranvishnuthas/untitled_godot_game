extends Area2D

export(Resource) var coin_type := load("res://Coins/CoinI.tres")

func _ready():
	$Sprite.texture = coin_type.texture

func _on_Coin_body_entered(body):
	if body.name == "Player":
		body.collect_coins(coin_type.value)
		queue_free()
