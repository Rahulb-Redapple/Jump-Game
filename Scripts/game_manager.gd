extends Node

var score: int = 0

signal on_coin_update(coin)

func add_points(point: int):
	score += point
	on_coin_update.emit(score)
