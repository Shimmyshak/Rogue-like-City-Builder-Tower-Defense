extends Node2D

onready var arrow = preload("res://Offense towers/lv1/Archer tower.tscn")
onready var fire = preload("res://Offense towers/lv1/Fire Spreader.tscn")
onready var furnace = preload("res://Offense towers/lv1/Furnace tower.tscn")
onready var ice = preload("res://Offense towers/lv1/Ice Tower.tscn")
onready var acid = preload("res://Offense towers/lv1/acid tower.tscn")
onready var electric = preload("res://Offense towers/lv1/electric.tscn")
onready var arrow2 = preload("res://Offense towers/lv2/Archer tower2.tscn")
onready var fire2 = preload("res://Offense towers/lv2/Fire Spreader2.tscn")
onready var furnace2 = preload("res://Offense towers/lv2/Furnace tower2.tscn")
onready var ice2 = preload("res://Offense towers/lv2/Ice Tower2.tscn")
onready var acid2 = preload("res://Offense towers/lv2/acid tower2.tscn")
onready var electric2 = preload("res://Offense towers/lv2/electric2.tscn")
onready var arrow3 = preload("res://Offense towers/lv3/Archer tower3.tscn")
onready var fire3 = preload("res://Offense towers/lv3/Fire Spreader3.tscn")
onready var furnace3 = preload("res://Offense towers/lv3/Furnace tower3.tscn")
onready var ice3 = preload("res://Offense towers/lv3/Ice Tower3.tscn")
onready var acid3 = preload("res://Offense towers/lv3/acid tower3.tscn")
onready var electric3 = preload("res://Offense towers/lv3/electric3.tscn")

func _ready():
	randomize()
	tower()
	yield(get_tree().create_timer(1.5),"timeout")
	queue_free()

var power

func tower():
	match randi()%6:
		0:
			if public.bias != 0.0:
				public.bias = 0.0
				public.roll = "archer"
				match power:
					1:
						instance_it(arrow)
					2:
						instance_it(arrow2)
					3:
						instance_it(arrow3)
			else:
				tower()
		1:
			if public.bias != 1.0:
				public.bias = 1.0
				public.roll = "fire"
				match power:
					1:
						instance_it(fire)
					2:
						instance_it(fire2)
					3:
						instance_it(fire3)
			else:
				tower()
		2:
			if public.bias != 2.0:
				public.bias = 2.0
				public.roll = "poison"
				match power:
					1:
						instance_it(furnace)
					2:
						instance_it(furnace2)
					3:
						instance_it(furnace3)
			else:
				tower()
		3:
			if public.bias != 3.0:
				public.bias = 3.0
				public.roll = "ice"
				match power:
					1:
						instance_it(ice)
					2:
						instance_it(ice2)
					3:
						instance_it(ice3)
			else:
				tower()
		4:
			if public.bias != 4.0:
				public.bias = 4.0
				public.roll = "soul"
				match power:
					1:
						instance_it(acid)
					2:
						instance_it(acid2)
					3:
						instance_it(acid3)
			else:
				tower()
		5:
			if public.bias != 5.0:
				public.bias = 5.0
				public.roll = "bolt"
				match power:
					1:
						instance_it(electric)
					2:
						instance_it(electric2)
					3:
						instance_it(electric3)
			else:
				tower()

func instance_it(it):
	yield(get_tree().create_timer(1.3),"timeout")
	var inst = it.instance()
	inst.global_position = get_global_mouse_position()
	get_tree().root.add_child(inst)
