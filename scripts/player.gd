extends CharacterBody2D

const SPEED = 130.0
const JUMP_VELOCITY = -300.0

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("move_left", "move_right")

	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle Run.
	if is_on_floor():
		if direction == 0:
			animated_sprite_2d.play("Idle")
		else:
			animated_sprite_2d.play("Run")

	# Handle Jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		if Input.is_action_pressed("move_down"):
			position.y += 1
		else:
			velocity.y = JUMP_VELOCITY

	# Detect if moving up or down
	if velocity.y < 0:
		animated_sprite_2d.play("Jump")
	elif velocity.y > 0:
		animated_sprite_2d.play("Fall")

	# Handle Flip.
	if direction < 0:
		animated_sprite_2d.flip_h = true
	elif direction > 0:
		animated_sprite_2d.flip_h = false

	# Handle Movement.
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	# Handle Attack.
	if Input.is_action_pressed("attack") and is_on_floor():
		animated_sprite_2d.play("Attack")

	# TODO: read docs about move_and_slide?
	move_and_slide()
