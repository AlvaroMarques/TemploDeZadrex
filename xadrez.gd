extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
func transform(a):
	var x = int(a)%8
	var y = int(int(a) / 8)
	return [x, y]


var pieces = {}
var eventMouseCounter = 0
var a = []
var turn = 1
# Called when the node enters the scene tree for the first time.
func _ready():
	$HTTPRequest.request("http://127.0.0.1:8000/?rei=1&pi=-1&pf=-1")
	for i in range(2, 10):
		a.append(load("res://sprite_0"+str(i)+".png"))
	for i in range(10, 16):
		a.append(load("res://sprite_"+str(i)+".png"))
	print(pieces)
	pass # Replace with function body.

var ps = [-1, -1]
var counter = 0
var evenMouse = 1
func _input(event):
	var abspos = 0
	# Mouse in viewport coordinates
	if event is InputEventMouseButton:
		var x = event.position.x
		var y = event.position.y
		var xmat = abs(round((x-261)/64))
		var ymat = abs(round((y-513)/64))
		abspos = ymat*8+xmat
		eventMouseCounter += 1
		
		
	if eventMouseCounter == 2:
		print(abspos)
		ps[counter] = abspos
		
		 
		counter += 1
		if counter == 2:
			$HTTPRequest.request("http://127.0.0.1:8000/?&pi=%d&pf=%d"%[ps[0], ps[1]])
			counter = 0
		eventMouseCounter = 0
		
func _on_HTTPRequest_request_completed( result, response_code, headers, body ):
	var json = JSON.parse(body.get_string_from_utf8())
	var tabuleiro = json.result["board"]
	var lista = PoolStringArray([])
	var tabsp = tabuleiro.split("\n")
	tabsp.invert()
	for i in tabsp:
		lista = lista +  i.split(" ")
	pieces = {}
	for i in range(64):
		if lista[i] != ".":
			pieces[i] = lista[i]
	if (json.result["check_mate"] != "nao"):
		if (json.result["check_mate"] == "branco"):
			get_tree().change_scene("res://fimpretas.tscn")
		else:
			get_tree().change_scene("res://fimbrancas.tscn")
			
	update()
	_draw()


func _draw():
	for i in pieces:
		
		if(pieces[i] == 'P'):
			draw_texture(a[0], Vector2(223+(transform(i)[0]*64), 480-(transform(i)[1]*64)))
		elif(pieces[i] == 'R'):
			draw_texture(a[1], Vector2(223+(transform(i)[0]*64), 480-(transform(i)[1]*64)))			
		elif(pieces[i] == 'N'):
			draw_texture(a[4], Vector2(223+(transform(i)[0]*64), 480-(transform(i)[1]*64)))			
		elif(pieces[i] == 'B'):	
			draw_texture(a[3], Vector2(223+(transform(i)[0]*64), 480-(transform(i)[1]*64)))			
		elif(pieces[i] == 'Q'):
			draw_texture(a[6], Vector2(223+(transform(i)[0]*64), 480-(transform(i)[1]*64)))			
		elif(pieces[i] == 'K'):
			draw_texture(a[5], Vector2(223+(transform(i)[0]*64), 480-(transform(i)[1]*64)))	
		elif(pieces[i] == 'p'):
			draw_texture(a[8], Vector2(223+(transform(i)[0]*64), 480-(transform(i)[1]*64)))
		elif(pieces[i] == 'r'):
			draw_texture(a[9], Vector2(223+(transform(i)[0]*64), 480-(transform(i)[1]*64)))			
		elif(pieces[i] == 'n'):
			draw_texture(a[10], Vector2(223+(transform(i)[0]*64), 480-(transform(i)[1]*64)))			
		elif(pieces[i] == 'b'):	
			draw_texture(a[13], Vector2(223+(transform(i)[0]*64), 480-(transform(i)[1]*64)))			
		elif(pieces[i] == 'q'):
			draw_texture(a[12], Vector2(223+(transform(i)[0]*64), 480-(transform(i)[1]*64)))			
		elif(pieces[i] == 'k'):
			draw_texture(a[11], Vector2(223+(transform(i)[0]*64), 480-(transform(i)[1]*64)))
		
	
   

  

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

