extends CanvasLayer

@onready var coin_text: Label = $CoinPanel/CoinText
@onready var game_manager: Node = %GameManager
@onready var pause_panel: Panel = $PausePanel

var main_menu = str("res://Scenes/main_menu.tscn")

func _ready() -> void:
	game_manager.on_coin_update.connect(update_coins)
	pause_panel.hide()

func update_coins(coin: int):
	coin_text.text = str(coin)	

func _on_pause_button_pressed() -> void:
	pause_panel.show()
	get_tree().paused = true

func _on_resume_button_pressed() -> void:
	pause_panel.hide()
	get_tree().paused = false

func _on_main_menu_button_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file(main_menu)
