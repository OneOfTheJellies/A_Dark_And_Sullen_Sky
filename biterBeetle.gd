extends CharacterBody2D


const speed = 300.0
const health = 3
@export var getPhysics : Node

var firstBeetle = load("res://Test project/biter_beetle.tscn")


var pointing := "left"

# stuff for walking 
var isWalking := false
var walkDirection := Vector2(1,0)

# stuff for jumping
const jumpPower = 500
const jumpDist = 200
var jumpTarget
var isAttacking
var jumpDirection
var jumpOvershoot = Vector2(0,-0.4)
var lookingForFooting := true
var footinglessTime := 2.5

var canChangeAnimation := true
var getdelta

func _ready():
		global_position = Vector2(50,100)

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
	if canChangeAnimation == true:
		lookingForFooting = false
		get_tree().create_timer(footinglessTime).timeout.connect(footinglessTimeout)
		if position.direction_to(targetLocation).x > 0 and pointing == "left":
			scale.x = -1
			pointing = "right"
		if position.direction_to(targetLocation).x < 0 and pointing == "right":
			scale.x = -1
			pointing = "left"
		$biterBeetleAnimations.play("attack")


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
	if !$cliffBumper.get_overlapping_bodies() and !$cliffBumper2.get_overlapping_bodies():
		pass
	if $hillBumper.get_overlapping_bodies() and $hillBumper2.get_overlapping_bodies():
		pass

func die():
	print ('"noooooo" - ' + name + ', last words ' + str(Time.get_datetime_string_from_unix_time(Time.get_unix_time_from_system(), true)))
	var newBeetle = firstBeetle.instantiate()
	get_parent().add_child(newBeetle)
	queue_free()
	
	# ADD MORE HERE IF NECESSARY, (e.x Respawning mechanics) | thx


func addVelocity(velocityAdded:Vector2):
	$CharacterPhysics.getVelocity(velocityAdded)

func checkFooting():
	if is_on_floor() and lookingForFooting and canChangeAnimation:
		if $CharacterPhysics.stableFooting == false:
			$CharacterPhysics.stableFooting = true
			$biterBeetleAnimations.play("idle")
	else:
		$CharacterPhysics.stableFooting = false

func footinglessTimeout():
	lookingForFooting = true

func stun(time):
	$biterBeetleAnimations.play("stun")
	canChangeAnimation = false
	get_tree().create_timer(time).timeout.connect(stunTimeout)

func stunTimeout():
	canChangeAnimation = true
