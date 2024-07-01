extends RigidBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("item interact"):
		translate(Vector2(0, -100))
		rotation = 0
	
	# if picked up -> get_parent().queue_free()
