extends CharacterBody2D


const SPEED = 100.0
const JUMP_VELOCITY = -400.0

func _ready():
	$AnimatedSprite2D.play("idle")


func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	print(is_on_floor())

	# Handle jump.
	if Input.is_action_pressed("left"):
		$AnimatedSprite2D.play("running")
		$AnimatedSprite2D.flip_h = true
		#velocity.y = JUMP_VELOCITY
	elif Input.is_action_pressed("right"):
		$AnimatedSprite2D.play("running")
		$AnimatedSprite2D.flip_h = false
	else:
		$AnimatedSprite2D.play("idle")

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
