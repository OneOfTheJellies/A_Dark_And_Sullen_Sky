extends Node

var currentVelocity := Vector2(0,0)

func _process(delta):
	applyAirResistance()
	applyFriction()
	applyGravity()
	applyWallBounce()
	move()

func applyGravity():
	currentVelocity.y += $"/root/Global".gravity

func applyAirResistance():
	currentVelocity *= $"/root/Global".airResistance

func applyFriction():
	if get_parent().is_on_floor() or get_parent().is_on_ceiling():
		currentVelocity *= $"/root/Global".friction

func applyWallBounce():
	if get_parent().is_on_wall():
		currentVelocity.x += currentVelocity.x * 1.5

func move():
	get_parent().velocity += currentVelocity
