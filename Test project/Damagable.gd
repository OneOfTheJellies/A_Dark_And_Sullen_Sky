extends Node

@export var parent : CharacterBody2D
var health:int
var healthShown:int


func _ready():
	health = get_parent().health
	healthShown = get_parent().health
	
func getHit(damage, source):
	health -= damage
	print ("oww! I, " + str(get_parent().name) + " got hurt for " + str(damage))
	get_parent().stun(damage)
	if get_parent().position.direction_to(source.position).x > 0:
		get_parent().addVelocity(Vector2(360*damage,-450*damage))
	else:
		get_parent().addVelocity(Vector2(-360*damage,-450*damage))
	if health <= 0:
		get_parent().die()
