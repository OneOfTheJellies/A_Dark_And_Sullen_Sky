extends Node

var currentVelocity := Vector2(0,0)
var currentMove := Vector2(0,0)
var stableFooting := false
func getVelocity(change):
	currentVelocity += change

func applyPhysics(delta):
	applyAirResistance(delta)
	applyFriction(delta)
	applyGravity(delta)
	applyTerminalVelocity()
	sendMove()

func applyGravity(delta):
	currentVelocity.y += $"/root/Global".gravity * delta

func applyAirResistance(delta):
	currentVelocity *= $"/root/Global".airResistance * delta

func applyFriction(delta):
	if get_parent().is_on_floor() or get_parent().is_on_ceiling() or get_parent().is_on_wall():
		currentVelocity *= $"/root/Global".friction * delta

func applyTerminalVelocity():
	if Vector2(0,0).distance_to(currentVelocity) > $"/root/Global".terminalVelocity:
		currentMove = Vector2(0,0).direction_to(currentVelocity) * $"/root/Global".terminalVelocity
	else:
		currentMove = currentVelocity

func sendMove():
	get_parent().velocity = currentVelocity
