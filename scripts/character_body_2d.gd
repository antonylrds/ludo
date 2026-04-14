extends CharacterBody2D


const SPEED = 100.0
const JUMP_VELOCITY = -300.0

var is_bouncing = false

func _ready():
	$AnimatedSprite2D.play("idle")

func should_run():
	if is_on_floor():
		$AnimatedSprite2D.play("running")
		
func bounce():
	if is_bouncing:
		velocity.y = JUMP_VELOCITY*1.25
	else:
		jump()
	is_bouncing = false
	
func jump():
	velocity.y = JUMP_VELOCITY
		

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		if Input.is_action_just_pressed("down"):
			is_bouncing = true
			velocity.y += get_gravity()[1]/2
		if velocity.y < 0:
			$AnimatedSprite2D.play("jump")
		elif velocity.y >= 0:
			$AnimatedSprite2D.play("fall")
		velocity += get_gravity() * delta
	elif is_bouncing:
		bounce()
	elif Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	elif Input.is_action_pressed("left"):
		should_run()
	elif Input.is_action_pressed("right"):
		should_run()
		$AnimatedSprite2D.flip_h = false
	else:
		$AnimatedSprite2D.play("idle")
	
	if velocity.x != 0:
		$AnimatedSprite2D.flip_h = velocity.x < 0

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()


func _on_area_2d_body_entered(body: Node2D) -> void:
	print("colidiu")
	if body.is_in_group("enemies"):
		bounce()
		print("inimigo")
	pass # Replace with function body.
