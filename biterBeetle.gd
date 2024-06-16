extends CharacterBody2D


const speed = 300.0
const health = 3
@export var getPhysics : Node

# stuff for jumping
const jumpPower = 720
const jumpDist = 200
var jumpTarget
var isAttacking
var jumpDirection
var jumpOvershoot = Vector2(0,-10)
var lookingForFooting := true
var footinglessTime := 2.5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var getdelta

func _physics_process(delta):
	print($biterBeetleAnimations.current_animation_position)
	getdelta = delta
	if isAttacking:
		handleAttack()
		if (lookingForFooting == false and is_on_floor() == false) or velocity.x < 1:
			lookingForFooting = true

#movement
	$CharacterPhysics.applyPhysics(delta)
	move_and_slide()
	checkFooting()
	$CharacterPhysics.doResets()

func handleAttack():
	for possibleTarget in $attackArea.get_overlapping_bodies():
		var viable = false
		if possibleTarget != self:
			for child in possibleTarget.get_children():
				if child.name == "Damageable":
					viable = true
			if viable == true:
				$biterBeetleAnimations.play("attack",8)
				isAttacking = false
				possibleTarget.find_child("Damageable").getHit(1)

func jumpAttack(targetLocation):
	jumpTarget = targetLocation
	lookingForFooting = false
	get_tree().create_timer(footinglessTime).timeout.connect(footinglessTimeout)
	$biterBeetleAnimations.play("attack")


func walkTowards(xspot,yspot):
	pass

# jump functions
func beginJump():
	$CharacterPhysics.stableFooting = false
	isAttacking = true
	addVelocity(jumpPower * position.direction_to(jumpTarget + jumpOvershoot))

func stopJumpAnim():
	$biterBeetleAnimations.pause()

func endJumpAnim():
	velocity = Vector2(0,0)

func die():
	pass


func addVelocity(velocityAdded:Vector2):
	$CharacterPhysics.getVelocity(velocityAdded)

func checkFooting():
	if ( is_on_ceiling() or is_on_floor() or is_on_wall() ) and lookingForFooting:
		if $CharacterPhysics.stableFooting == false:
			$CharacterPhysics.stableFooting = true
			$biterBeetleAnimations.play("idle")
	else:
		$CharacterPhysics.stableFooting = false

func footinglessTimeout():
	lookingForFooting = true
