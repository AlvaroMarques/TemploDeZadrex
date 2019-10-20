extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var eventMouse = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

var ps = [-1, -1]
var counter = 0
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
		ps[counter] = abspos 
		counter += 1
		if counter == 2:
			$HTTPRequest.request("http://127.0.0.1:8000/?pi=%d&pf=%d"%[ps[0], ps[1]])
			counter = 0
		eventMouse = 0
		
func _on_HTTPRequest_request_completed( result, response_code, headers, body ):
	var json = JSON.parse(body.get_string_from_utf8())
	var tabuleiro = json.result["tabuleiro"]
	var lista = PoolStringArray([])
	var tabsp = tabuleiro.split("\n")
	tabsp.invert()
	for i in tabsp:
		lista = lista +  i.split(" ")
	var d = {}
	for i in range(64):
		if lista[i] != ".":
			d[i] = lista[i]
		
	print(d)
		
	
   

  

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
