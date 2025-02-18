extends Node

# This variables can be accesed from any function in code. Global variables
var health = 100
var script_variable = 100 

var s_damage : int = 15 #staticly defining this variable as int
var a_damage := 15 # automatically defining this variable as int

@export var i_damage := 15 #To show this variable in inspector also can change value from there

const GRAVITY = -9.81 # constant variable

enum PlayerType {NONE, ALLY, NEUTRAL, ENEMY} #defining an enum
#can set index of enum values also like this. can write in c# style also
const NONE = 0
const ALLY = 1
const NEUTRAL = 2
const ENEMY = 3

@export var playerType : PlayerType #assigning enum

#Modifying nodes
@onready var graphics_node: Sprite2D = get_node("PlayerNode/GraphicsNode")

#set any node on inspector
@export var my_node : Node

var xp := 0
signal leveled_up #non parameterized signal
signal leveled_up_msg(msg) #parameterized signal
signal score_changed(new_score)

#Getter
var score := 100:
	set(value):
		score = clamp(value, 0, 100)
		score_changed.emit(score)
		
#Setter
var chance := 15
var Chance:
	get:
		return chance
	set(value):
		chance = value	

# Called when the node enters the scene tree for the first time.
func _ready():
	$NameText.modulate = Color.GREEN
	
	#get path of a node
	print(graphics_node.get_path()) 
	
	#check type of node
	if my_node is Node:
		print("It is node")
	
	#Casting to string
	var number = 42
	var text = "Number : " + str(number)
	print(text)
	
	#Truncating to int
	var pi = 3.14
	print(int(pi))
	
	#Vectors
	var position = Vector3(3, -10, 5)
	position.x += 2
	print(position)
	
	print(i_damage)
	
	add(10, 55)
	add(111, 256)
	
	var result = ret_add(100 , 256)
	print(result)
	
	var d_result = def_add(200, 215)
	print(d_result)
	
	random_number()
	random_range()
	array()
	dictionary()
	my_enum()
	switch_case()
	
	#To subscribe the callback function to leveled_up signal
	leveled_up.connect(_on_leveled_up)
	#To subscribe a parameterized callback function to parameterized leveled_up_msg signal
	leveled_up_msg.connect(_on_leveled_up_msg)
	score_changed.connect(_on_score_changed)
	
	changeScore(72)
	
	#Getter setter
	print("Chance :: " + str(chance))
	Chance = 25
	print("Chance :: " + str(chance))

func _input(event: InputEvent):
	if(event.is_action_pressed("color_change_action")):
		$NameText.modulate = Color.BLUE
	
	if(event.is_action_released("color_change_action")):
		$NameText.modulate = Color.RED	
		
	if(event.is_action_pressed("health_action")):
		if(health > 0):
			health -= 10
			print(health)
		
			if(health <= 0):
				health = 0
				print("Dead")
			elif (health < 50):
				print("You are low")
			else:
				print("Not low health")		
				
	if(event.is_action_pressed("jump_action")):
		jump()			

#Use pass keyword for any empty function
func myfunction():
	pass
	
#Custom function
func jump():
	print("Jump")	
	
#parameterized function	
func add(num1, num2):
	var result = num1 + num2	
	print(result)
	
#return type function withou defining anything	
func ret_add(num1, num2):
	var result = num1 + num2
	return result	
	
#return type function defining parameters	
func def_add(num1 : int, num2 : int) -> int:
	var result = num1 + num2
	return result	
	
#for random number	
func random_number():
	var roll = randf()	
	if roll <= 0.8:
		print("Common")
	else: 
		print("Rare")	 
		
#for randomize number
func random_range():
	var num = randi_range(140, 210)
	print("Random number is " + str(num))		
	
#for arrays	
func array():
	var items = ["Hello", 5, 6] #can mix match datatype in array
	var def_items: Array[String] = ["Apple", "Banana", "Grapes"] #defined string array
	
	print("Array element at " + str(1) + " " + def_items[1]) #can print elements by giving index in array	
	
	def_items[1] = "Guava" #can change element at given index
	print("Array element at " + str(1) + " " + def_items[1])
	
	def_items.remove_at(2) #can remove element from given index
	def_items.append("Orange") #can add element in an array
	
	#Loop to iterate an array
	for item in def_items:
		print(item)
		
	#conditional loop array	
	for item in def_items:
		if item.length() > 5:
			print("Has more than 5 letter " + item)	
			
	#loop to run certain amount of time
	for n in 8:
		print(n)	
		
	#while loop
	var k:= 0.0
	while k < 2:
		k += 0.5
		print("Value of k : " + str(k))		
		
#for dictionaries
func dictionary():
	var my_dict = {"Car" : 10, "Shop" : 25, "Fruit" : 30}
	
	my_dict["Fruit"] = 50 #can change value of given key
	my_dict["Bottle"] = 66 #can add new element
	
	for keys in my_dict:
		print(keys + ": " + str(my_dict[keys]))
		
	var players_dict = {
		"Crook" : {"Level" : 1, "Health" : 10},
		"Villain" : {"Level" : 10, "Health" : 25},
		"Boss" : {"Level" : 20, "Health" : 50}
	}
	print(players_dict["Boss"]["Health"])
	
#for enum
func my_enum():
	if playerType == PlayerType.ALLY:
		print("Ally")
	elif playerType == PlayerType.NEUTRAL:
		print("Neutral")
	elif(playerType == PlayerType.ENEMY):
		print("Enemy")
	else:
		print("Nothing")	
		
	print("Enemy index : " + str(PlayerType.ENEMY))			
	
#for match(switch case)
func switch_case():
	match playerType:
		PlayerType.ALLY:
			print("Ally")
		PlayerType.NEUTRAL:
			print("Neutral")
		PlayerType.ENEMY:
			print("Enemy")
		_: #default case
			print("Default")					

#on button click callback
func _on_button_pressed() -> void:
	print("MONEY")

#timer callback after 1sec
func _on_timer_timeout() -> void:
	xp += 5
	print("Xp :: " + str(xp))
	if xp >= 20:
		xp = 0
		leveled_up.emit()
		leveled_up_msg.emit("Hurray")
		
#leveled_up() signal callback
func _on_leveled_up() -> void:
	print("Performed")
	
func _on_leveled_up_msg(msg):
	print(msg)			
	
func _on_score_changed(new_score):
	print(new_score)	
	
func changeScore(new_score):
		score = new_score
