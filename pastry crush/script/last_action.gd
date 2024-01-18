extends Node2D
var counter = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	print("last action added")

func _process(delta):
	if Global.checking == false:
		if Global.destroying == true:
			Global.doublecheck = true
		
		
	elif Global.found == true:
		Global.destroying = true
		print("destroying is ", Global.destroying)
	Global.checking = false
	Global.found = false
