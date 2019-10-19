extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var eventMouse = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
func _input(event):
	var abspos = 0
	# Mouse in viewport coordinates
	if event is InputEventMouseButton:
		var x = event.position.x
		var y = event.position.y
		var xmat = abs(round((x-261)/64))
		var ymat = abs(round((y-513)/64))
		abspos = ymat*8+xmat
		eventMouse += 1
	if eventMouse == 2:
		print(abspos) 
		eventMouse = 0
		
		
		
		
	
   

  

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
