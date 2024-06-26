extends Node

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if !get_parent().is_on_floor() and !get_parent().isJumping:
		get_parent().velocity.y += gravity * delta
