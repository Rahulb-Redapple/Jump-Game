extends Area2D

@onready var game_manager: Node = %GameManager
@onready var pickup_sound: AudioStreamPlayer2D = $PickupSound
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var timer: Timer = $CoinCollectedTimer


func _on_body_entered(body: Node2D) -> void:
	timer.start()
	game_manager.add_points(1)
	animated_sprite_2d.visible = false
	collision_shape_2d.disabled = true
	pickup_sound.play()

func _on_timer_timeout() -> void:
	queue_free()
