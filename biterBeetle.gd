extends CharacterBody2D


const speed = 300.0
const health = 3
@export var map : TileMap

# stuff for jumping
const jumpSpeed = 1800
const jumpDist = 200
var jumpTarget
var isJumping
var jumpInactive = true


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var getdelta

func _physics_process(delta):
	getdelta = delta
	if isJumping:
		if checkForCollisions() == true:
			isJumping = false
			$biterBeetleAnimations.play("attack",8)
		else:
			handleAttack()
			handleJump(delta)

	move_and_slide()

func handleAttack():
	for possibleTarget in $attackArea.get_overlapping_bodies():
		var viable = false
		if possibleTarget != self:
			print(possibleTarget)
			for child in possibleTarget.get_children():
				if child.name == "Damageable":
					viable = true
			if viable == true:
				possibleTarget.find_child("Damageable").getHit(1)

func handleJump(delta):
	if position.distance_to(jumpTarget) > 20:
		velocity = position.direction_to(jumpTarget) * minf(jumpSpeed, position.distance_to(jumpTarget))
	else:
		$biterBeetleAnimations.play("attack",8)
		isJumping = false

func jumpAttack(targetLocation):
	jumpTarget = targetLocation
	$biterBeetleAnimations.play("attack")
	

func walkTowards(xspot,yspot):
	pass

# jump functions
func beginJump():
	rotation = position.angle_to(jumpTarget)
	isJumping = true
	jumpInactive = false

func stopJumpAnim():
	$biterBeetleAnimations.pause()

func endJumpAnim():
	velocity = Vector2(0,0)
	jumpInactive = true

func die():
	pass

func checkForCollisions():
	if is_on_ceiling() or is_on_wall():
		if !is_on_floor():
			return true
	if get_last_slide_collision():
		if get_last_slide_collision().get_collider().get_script():
			return true
		else:
			return false
