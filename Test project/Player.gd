extends CharacterBody2D

const SPEED = 200.0
const JUMP_VELOCITY = -400.0
const jumpBufferLength = 0.2
const cyoteTimeLength = 0.2
const health = 1

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var jumpAvailable:bool = false
var jumpBuffer:bool = false
var wasOnFloor:bool = false
var drift = false

func _physics_process(delta):
	if not is_on_floor():
		if not drift:
			velocity.y += gravity * delta
		else: 
			velocity.y = gravity * delta * 3
		if wasOnFloor:
			get_tree().create_timer(cyoteTimeLength).timeout.connect(cyoteTimeout)
	else:
		jumpAvailable = true
		wasOnFloor = true
		if jumpBuffer:
			jump()

	if position.y > 640:
		reset_local()

	# Handle jump.
	if Input.is_action_just_pressed("jump"):
		jump()
	if velocity.y > 0 and Input.is_action_pressed("down"):
		drift = true
	else:
		drift = false

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("left", "right")
	if direction:
		if not drift:
			velocity.x = direction * SPEED
		else: 
			velocity.x = direction * SPEED / 1.5
		$PlayerAnimations.play("walk",1)
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		$PlayerAnimations.play("idle",1)

	if drift:
		$PlayerAnimations.play("float",1)
	if velocity.x < 0:
		$PlayerAnimations.flip_h = true
	if velocity.x > 0:
		$PlayerAnimations.flip_h = false

	move_and_slide()

func jump():
	if jumpAvailable:
		velocity.y = JUMP_VELOCITY
		jumpBuffer = false
	else:
		jumpBuffer = true
		get_tree().create_timer(jumpBufferLength).timeout.connect(bufferTimeout)
	jumpAvailable = false

func cyoteTimeout():
	jumpAvailable = false

func reset_local():
	global_position = Vector2(64*9,2.5*9)
	$Damageable.health = health

func bufferTimeout():
	jumpBuffer = false

func die():
	reset_local()
