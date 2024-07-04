extends CharacterBody2D

const SPEED = 200.0
const JUMP_VELOCITY = -300.0
const jumpBufferLength = 0.2
const cyoteTimeLength = 0.2
const health = 3


var gravity
var jumpAvailable:bool = false
var jumpBuffer:bool = false
var wasOnFloor:bool = false
var drift = false
var Targets : Array
var directionFacing := "right"


var weapon1:String = ""


func _ready():
	gravity = $"/root/Global".gravity

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
	if velocity.x > 0 and directionFacing == "left":
		scale.x = -1
		directionFacing = "right"
	if velocity.x < 0 and directionFacing == "right":
		scale.x = -1
		directionFacing = "left"
	
	
	if Input.is_action_just_pressed("item interact"):
		for Targets in $Melee1.get_overlapping_bodies():
			var viable = false
			if Targets != self:
				for child in Targets.get_children():
					if child.name == "Damageable":
						viable = true
				if viable == true:
					Targets.find_child("Damageable").getHit(1)
	
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
	global_position = Vector2(64*9,38)
	$Damageable.health = health 

func bufferTimeout():
	jumpBuffer = false

func die():
	reset_local()


func _on_melee_1_body_entered(body):
	print ("Entered")
	for child in body.get_children():
	#	if child.name == "Targetable":
		Targets.append(body)
		print ("Added")



func _on_melee_1_body_exited(body):
	print ("Exited")
	if Targets.has(body):
		Targets.erase(body)
