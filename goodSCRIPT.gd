extends RigidBody2D



# Called when the node enters the scene tree for the first time.
func _ready():
	print("If you are seeing this, good job! You remembered to sync changes!") # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if Input.is_action_just_pressed("item interact"):
		if $Area2D.get_overlapping_bodies().has(get_parent().get_child(name == ("Player"))):
			get_parent().get_child(name == ("Player")).getItem("res://OP_sword_dropped.tscn" , "Melee", 4 , 2)
			queue_free()
	
# I changed player script to flip properly - OneOfTheJellies

# Thanks "OneOfTheJellies" - Someone...
	
#	if Input.is_action_just_pressed("item interact"):
#		translate(Vector2(0, -100))
#		rotation = 0
	
	# if picked up -> get_parent().queue_free()


func _on_area_2d_body_entered(body):
	pass # Replace with function body.


func _on_area_2d_body_exited(body):
	pass # Replace with function body.
