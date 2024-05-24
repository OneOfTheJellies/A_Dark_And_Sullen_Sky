extends CharacterBody2D


const speed = 300.0
const health = 3

# stuff for jumping
const jumpSpeed = 8
const jumpDist = 100
var jumpTarget
var isJumping


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var getdelta

func _physics_process(delta):
	getdelta = delta
	if isJumping:
		handleJump(delta)

	move_and_slide()

func handleJump(delta):
	if position.distance_to(jumpTarget) > 10:
		velocity = position.direction_to(jumpTarget) * minf(speed, position.distance_to(jumpTarget))
	else:
		$biterBeetleAnimations.play()
		isJumping = false

func jumpAttack(targetLocation):
	jumpTarget = targetLocation
	if position.distance_to(targetLocation) > jumpSpeed:
		var max_speed = (position.distance_to(targetLocation) / getdelta)
		velocity = position.direction_to(targetLocation) * minf(speed, max_speed)

func walkTowards(xspot,yspot):
	pass

# jump functions
func beginJump():
	rotation = position.angle_to(jumpTarget.position)
	isJumping = true
	$biterBeetleAnimations.play("attack")

func stopJumpAnim():
	$biterBeetleAnimations.pause()
