extends Label


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func display(textHere:String):
	text = (textHere)
	get_tree().create_timer(0.5).timeout.connect(hideText)

func hideText():
	text = ""
