extends RigidBody2D



# Called when the node enters the scene tree for the first time.
func _ready():
	print("MWAHAHA! I AM SOOOooOoOOO (kind of...) POWERFULL!!!!") # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if Input.is_action_just_pressed("item interact"):
		if $Area2D.get_overlapping_bodies().has(get_parent().get_child(name == ("Player"))):
			get_parent().get_child(name == ("Player")).getItem("res://sword_dropped.tscn" , "Melee", 0.5 , 1) #Path to scene, Type, Speed, Damage
			queue_free()
	
# I changed player script to flip properly - OneOfTheJellies

# Thanks "OneOfTheJellies" - Someone... who is totally not "PixiePeace9" (I kept on pressing "c" instead of "x" whil typing that for some reason... Also this line is tooooo long now!)
	
#	if Input.is_action_just_pressed("item interact"):
#		translate(Vector2(0, -100))
#		rotation = 0
	
	# if picked up -> get_parent().queue_free()


func _on_area_2d_body_entered(body):
	pass # Replace with function body.


func _on_area_2d_body_exited(body):
	pass # Replace with function body.
