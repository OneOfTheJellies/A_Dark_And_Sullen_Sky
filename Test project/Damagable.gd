extends Node
@export var parent : CharacterBody2D
var health:int
var healthShown:int

func _ready():
	health = get_parent().health
	healthShown = get_parent().health
	
func getHit(damage):
	health -= damage
	print ("oww! I, " + str(get_parent().name) + " got hurt for " + str(damage))
	if health <= 0:
		get_parent().die()
