extends Area2D

#onready var line = $Line2D

export var AOE = false #area of effect. will do damage to all enemys in range
export var type = ""
export var damage = 2.0
export var attack_spd = 1.0 #seconds
export var removal = false #remove target after attack.
onready var atk_range = $CollisionShape2D
onready var mod = 0 #who is working here
var target = null
var attackable = true
var en_array = []

onready var aoe = preload("res://Enemies/aoe symbol.tscn")
onready var projectile = preload("res://Enemies/fireball.tscn")

func _ready():
	
#	line.add_point(global_position)
	yield(get_tree().create_timer(randf()),"timeout")
	while true:
		yield(get_tree().create_timer(attack_spd),"timeout")
		attackable = true

var build_valid = false
var click = false
func _process(delta):
	if public.lose:
		queue_free()
	if !click:
#		global_position = get_global_mouse_position()
		var current_tile = get_node ("../Node2D/path").world_to_map(get_global_mouse_position())
		var tile_position = get_node("../Node2D/path").map_to_world(current_tile)
		if get_node("../Node2D/path").get_cellv(current_tile) == -1:
			build_valid = true
			global_position.x = tile_position.x + 32
			global_position.y = tile_position.y + 32
		if Input.is_action_just_pressed("l_click"):
			get_node("../Node2D/path").set_cellv(current_tile,1)
			click = true
	else:
		attack_target()

func attack_target():
	if mod == 0: #might be in final, if time.
		if attackable and en_array.size() != 0: #if the tree has an enemy and attack timer is up
			if AOE:
				attackable = false
				for x in en_array.size():
					en_array[x].damage(damage,type)
				var inst = aoe.instance()
				if type == "": #poison
					add_child(inst)
					audio.play("res://assets/noises/powerUp.wav")
				elif type == "acid":
					inst.animation = "hex"
					audio.play("res://assets/noises/blipSelect.wav")
					inst.show_behind_parent = true
					add_child(inst)
				else:
					inst.animation = "ice"
					audio.play("res://assets/noises/blipSelect (1).wav")
					inst.show_behind_parent = true
					add_child(inst)
			else:
				var inst = projectile.instance()
				if type == "": #arrow
					inst.animation("arrow")
					audio.play("res://assets/noises/hitHurt (1).wav")
				elif type == "lec":
					inst.animation("bolt")
					audio.play("res://assets/noises/synth.wav")
				else:
					audio.play("res://assets/noises/explosion (1).wav")
				inst.target = en_array[0].global_position
				inst.position.y -= 40
				add_child(inst)
				attackable = false
				yield(get_tree().create_timer(0.1),"timeout")
				if en_array.size() != 0:
					en_array[0].damage(damage,type)

	
func mod_change(new_mod):
	match mod: #remove old passive buff
		1: #races represented with numbers 1-4
			damage /= 1.2 #dwarf is one
		2: 
			attack_spd /= 1.2#tieflings are 2
		3: 
			atk_range.shape.radius -= 30.0 #Elves are 3
		4:
			pass #humans are 4 (not sure what to give them)
	mod = new_mod
	match new_mod: #add passive buff
		1:
			damage *= 1.2
		2:
			attack_spd *= 1.2
		3:
			atk_range.shape.radius += 30.0
		4:
			pass

func _on_Archer_tower_body_entered(body): #the body should always be an enemy
	en_array.append(body)
func _on_Archer_tower_body_exited(body):
	en_array.erase(body)
