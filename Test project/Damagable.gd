extends Node
@export var parent : CharacterBody2D
var health:int

func _ready():
	health = get_parent().health

func getHit(damage):
	health -= damage
	print(health)
	if health <= 0:
		get_parent().get_parent().find_child("healthBar").find_child("healthBarAnimations").play()
		get_parent().die()
