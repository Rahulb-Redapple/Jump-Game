extends CharacterBody2D

@export var SPEED: int = 130.0
@export var JUMP_VELOCITY: int = -300.0

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var audio_manager: Node = %AudioManager

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		audio_manager.play_jump_sound()

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	
	# Get the input direction: -1, 0, 1
	var direction := Input.get_axis("move_left", "move_right")
	
	# Apply movement
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	# Flip sprite	
	if(direction == 1):
		animated_sprite.flip_h = false	
	elif direction == -1:
		animated_sprite.flip_h = true
		
	# Play animations
	if is_on_floor():
		if direction == 0:
			animated_sprite.play("idle")
		else:
			animated_sprite.play("run")	
	else:
		animated_sprite.play("jump")						

	move_and_slide()	
