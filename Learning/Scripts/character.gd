class_name Character
extends Node

@export var characterName : String
@export var health : int

var chest = Equipments.new()
var legs = Equipments.new()

func _ready() -> void:
	chest.armor = 26
	print(chest.armor)
	print(legs.weight)

func die():
	health = 0
	print(characterName + " died")	
	
class Equipments:
	var armor := 10
	var weight := 5	
