extends Node
@export var parent : CharacterBody2D
var health =  0

func _ready():
	health = parent.getHealth()

func getHit(damage):
	health -= damage

	if health <= 0:
		get_parent().die()
