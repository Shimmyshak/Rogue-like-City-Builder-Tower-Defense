extends Node2D

onready var arrow = preload("res://Offense towers/Archer tower.tscn")
onready var fire = preload("res://Offense towers/Fire Spreader.tscn")
onready var furnace = preload("res://Offense towers/Furnace tower.tscn")
onready var ice = preload("res://Offense towers/Ice Tower.tscn")
onready var acid = preload("res://Offense towers/acid tower.tscn")
onready var electric = preload("res://Offense towers/electric.tscn")

func _ready():
	randomize()
	tower()
	yield(get_tree().create_timer(0.2),"timeout")
	queue_free()

func tower():
	match round(rand_range(0,5)):
		0.0:
			if public.bias != 0.0:
				public.bias = 0.0
				instance_it(arrow)
			else:
				tower()
		1.0:
			if public.bias != 1.0:
				public.bias = 1.0
				instance_it(fire)
			else:
				tower()
		2.0:
			if public.bias != 2.0:
				public.bias = 2.0
				instance_it(furnace)
			else:
				tower()
		3.0:
			if public.bias != 3.0:
				public.bias = 3.0
				instance_it(ice)
			else:
				tower()
		4.0:
			if public.bias != 4.0:
				public.bias = 4.0
				instance_it(acid)
			else:
				tower()
		5.0:
			if public.bias != 5.0:
				public.bias = 5.0
				instance_it(electric)
			else:
				tower()

func instance_it(it):
	var inst = it.instance()
	inst.global_position = get_global_mouse_position()
	get_tree().root.add_child(inst)
