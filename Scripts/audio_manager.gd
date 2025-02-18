extends Node

@onready var jump_sound: AudioStreamPlayer2D = $JumpSound

func play_jump_sound():
	jump_sound.play()
