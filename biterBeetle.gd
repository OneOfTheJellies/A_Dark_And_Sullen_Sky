extends CharacterBody2D


const speed = 300.0
const health = 3
@export var getPhysics : Node

var pointing := "left"

# stuff for walking 
var isWalking := false
var walkDirection := Vector2(1,0)

# stuff for jumping
const jumpPower = 720
const jumpDist = 200
var jumpTarget
var isAttacking
var jumpDirection
var jumpOvershoot = Vector2(0,-0.2)
var lookingForFooting := true
var footinglessTime := 2.5


var getdelta

func _physics_process(delta):
	getdelta = delta
	if isAttacking:
		handleAttack()
		if (lookingForFooting == false and is_on_floor() == false) or velocity.x < 1:
			lookingForFooting = true
	if isWalking == true:
		handleWalk()

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
	if position.direction_to(targetLocation).x > 0 and pointing == "left":
		scale.x = -1
		pointing = "right"
	if position.direction_to(targetLocation).x < 0 and pointing == "right":
		scale.x = -1
		pointing = "left"
	$biterBeetleAnimations.play("attack")


func walkTowards(xspot,yspot):
	pass

# jump functions
func beginJump():
	$CharacterPhysics.stableFooting = false
	isAttacking = true
	addVelocity(jumpPower * position.direction_to(jumpTarget + Vector2(0,minf(80.0 , jumpOvershoot.y * position.distance_to(jumpTarget))) ))

func stopJumpAnim():
	$biterBeetleAnimations.pause()

func endJumpAnim():
	velocity = Vector2(0,0)

func handleWalk():
	if find_child("CharacterPhysics").stableFooting == true:
		addVelocity(speed * walkDirection)
	if !$bumper.get_overlapping_bodies():
		pass

func die():
	queue_free()
	# ADD MORE HERE IF NECESSARY, (e.x Respawning mechanics)


func addVelocity(velocityAdded:Vector2):
	$CharacterPhysics.getVelocity(velocityAdded)

func checkFooting():
	if is_on_floor() and lookingForFooting:
		if $CharacterPhysics.stableFooting == false:
			$CharacterPhysics.stableFooting = true
			$biterBeetleAnimations.play("idle")
	else:
		$CharacterPhysics.stableFooting = false

func footinglessTimeout():
	lookingForFooting = true
