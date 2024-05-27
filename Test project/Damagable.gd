extends Node
@export var parent : CharacterBody2D
var health =  0

func _ready():
	health = get_parent().health

func getHit(damage):
#	health -= damage

#	if health <= 0:
	get_parent().die()
