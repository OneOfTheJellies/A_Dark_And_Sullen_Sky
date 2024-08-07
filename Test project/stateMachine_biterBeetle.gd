extends Node

var state : String = "idle"
var homeScene : Vector2

# Walking

# Targeting
var possibleTargets : Array
var target : CharacterBody2D
var walkDirection : Vector2

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if target:
		if is_instance_valid(target):
			state = "attack"
		else:
			possibleTargets.erase(target)
			target = null
			state = "idle"
	else:
		state = "idle"
	if state == "idle":
		idleProcess()
	if state == "attack":
		attackProcess()
	

func idleProcess():
	if !target:
		lookForTarget()
	if !target:
		get_parent().isWalking = true
	else:
		get_parent().isWalking = false

func attackProcess():
	if get_parent().position.distance_to(target.global_position) < get_parent().jumpDist and get_parent().getPhysics().stableFooting == true:
		if lookForSight(target) == true and get_parent().is_on_floor():
			if !get_parent().find_child("biterBeetleAnimations").current_animation == "attack":
				get_parent().jumpAttack(target.global_position)
#  when someting enters the targeting area, this adds it to a list of targets 
#  to test line of sight to. The second function deletes it if it leaves.
func _on_tageting_area_body_entered(body):
	var isTargetable = false
	for child in body.get_children():
		if child.name == "Targetable":
			isTargetable = true
	if isTargetable:
		possibleTargets.append(body)

func _on_tageting_area_body_exited(body):
	if possibleTargets.has(body):
		possibleTargets.erase(body)

func lookForTarget():
	var bestTarget
	var bestTargetDistance = 0.0
	for testTarget in possibleTargets:
		if lookForSight(testTarget):
			if get_parent().global_position.distance_to(testTarget.global_position) > bestTargetDistance:
				bestTarget = testTarget
	target = bestTarget

func lookForSight(thingToSee):
	var space_state = get_parent().get_world_2d().direct_space_state
	var query = PhysicsRayQueryParameters2D.create(get_parent().global_position, thingToSee.global_position)
	query.exclude = [self]
	var result = space_state.intersect_ray(query)
	if result.get('collider') == thingToSee:
		return true
	else:
		return false
