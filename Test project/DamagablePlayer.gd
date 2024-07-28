extends Node
@export var parent : CharacterBody2D
var health:int
var healthShown:int

func _ready():
	health = get_parent().health
	checkHealthFull()

func checkHealthFull():
	if health == 3:
		get_parent().get_parent().find_child("healthBar").find_child("healthBarAnimations").play("full")

func getHit(damage, source):
	health -= damage
	if health != healthShown:
		if health < healthShown:
			get_parent().get_parent().find_child("healthBar").find_child("healthBarAnimations").play("downTo"+str(health))
			healthShown -= 1
		else:get_parent().get_parent().find_child("healthBar").find_child("healthBarAnimations").play("downTo"+str(health),-1)
			
