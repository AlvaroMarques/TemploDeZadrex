extends Node2D

var initial = 0
var final = 0

var pieces = {0: 'R',
 1: 'N',
 2: 'B',
 3: 'Q',
 4: 'K',
 5: 'B',
 6: 'N',
 7: 'R',
 8: 'P',
 9: 'P',
 10: 'P',
 12: 'P',
 13: 'P',
 14: 'P',
 15: 'P',
 11: 'P',
 48: 'p',
 49: 'p',
 50: 'p',
 51: 'p',
 52: 'p',
 53: 'p',
 54: 'p',
 55: 'p',
 56: 'r',
 57: 'n',
 58: 'b',
 59: 'q',
 60: 'k',
 61: 'b',
 62: 'n',
 63: 'r'}
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var eventMouse = 1
var a = []

		
func transform(a):
	var x = int(a)%8
	var y = int(int(a) / 8)
	return [x, y]
	
# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(2, 10):
		a.append(load("res://sprite_0"+str(i)+".png"))
	for i in range(10, 16):
		a.append(load("res://sprite_"+str(i)+".png"))
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
		if eventMouse == 1:
			if pieces.has(int(abspos)):
				initial = int(abspos)
				eventMouse += 1
		elif eventMouse == 2:
			print(abspos) 
			eventMouse += 1
		elif eventMouse == 3:
			final = int(abspos)
			eventMouse += 1
		elif eventMouse == 4:
			pieces[final] = pieces[initial]
			pieces.erase(initial)
			update()
			_draw()
			eventMouse = 1
	
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
			draw_texture(a[12], Vector2(223+(transform(i)[0]*64), 480-(transform(i)[1]*64)))			
		elif(pieces[i] == 'q'):
			draw_texture(a[13], Vector2(223+(transform(i)[0]*64), 480-(transform(i)[1]*64)))			
		elif(pieces[i] == 'k'):
			draw_texture(a[11], Vector2(223+(transform(i)[0]*64), 480-(transform(i)[1]*64)))	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
