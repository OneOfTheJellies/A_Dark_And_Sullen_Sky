extends Node

var currentVelocity := Vector2(0,0)
var stableFooting := false
func getVelocity(change):
	currentVelocity += change

func applyPhysics(delta):
	applyAirResistance(delta)
	applyFriction(delta)
	applyGravity(delta)
	move()

func applyGravity(delta):
	currentVelocity.y += $"/root/Global".gravity * delta

func applyAirResistance(delta):
	currentVelocity *= $"/root/Global".airResistance * delta

func applyFriction(delta):
	if get_parent().is_on_floor() or get_parent().is_on_ceiling() or get_parent().is_on_wall():
		currentVelocity *= $"/root/Global".friction * delta

func move():
	get_parent().velocity = currentVelocity


func doResets():
	if stableFooting == true:
		currentVelocity = Vector2(0,0)
	else:
		applyBounce()

func applyBounce():
	if get_parent().is_on_wall():
		currentVelocity.x += currentVelocity.x * -1.5
	if get_parent().is_on_ceiling() or get_parent().is_on_floor():
		currentVelocity.y += currentVelocity.y * -1.5
