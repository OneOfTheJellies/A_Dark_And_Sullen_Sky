extends Node

var state : String

#Targeting
var possibleTargets : Array
var target : Vector2
var destination : Vector2
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if state == "idle":
		idleProcess()

#  when someting enters the targeting area, this adds it to a list of targets 
#  to test line of sight to. The second function deletes it if it leaves.
func _on_tageting_area_body_entered(body):
	var isTargetable = false
	for child in body.get_children():
		if child.name == "Targetable":
			isTargetable = true
	if isTargetable:
		possibleTargets.append(body)
		print(possibleTargets)

func _on_tageting_area_body_exited(body):
	if possibleTargets.has(body):
		possibleTargets.erase(body)

func idleProcess():
	pass
