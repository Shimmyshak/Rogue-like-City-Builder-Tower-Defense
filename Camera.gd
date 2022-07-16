extends Camera2D

onready var dice = preload("res://Enemies/weapon dice.tscn")

var cam_spd = 3
const min_zoom = Vector2(0.6,0.6)
const max_zoom = Vector2(2,2)
const zoom_spd = Vector2(0.2,0.2)

func _ready():
	pass

func _process(delta):
	
	if Input.is_action_pressed("up"):
		position.y -= cam_spd * zoom.x
	if Input.is_action_pressed("down"):
		position.y += cam_spd * zoom.x
	if Input.is_action_pressed("left"):
		position.x -= cam_spd * zoom.x
	if Input.is_action_pressed("right"):
		position.x += cam_spd * zoom.x
	if Input.is_action_just_pressed("dice"): #add price
		var inst = dice.instance()
		self.add_child(inst)
	#clamp function here

func _input(event):
	if event is InputEventMouseButton:
		if event.is_pressed(): # if a mouse button is pressed
			if event.button_index == BUTTON_WHEEL_UP: # if its mouse up
				if zoom > min_zoom: # if we aren't past minimum zoom
					zoom -= zoom_spd #zoom in
			elif event.button_index == BUTTON_WHEEL_DOWN:
				if zoom < max_zoom:
					zoom += zoom_spd
	


