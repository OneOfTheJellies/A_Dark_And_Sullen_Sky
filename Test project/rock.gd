extends CollisionPolygon2D

var rightHand = "NA"
var leftHand = "NA"
var hasItemOn

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("item interact"):
		if hasItemOn:
			pass
