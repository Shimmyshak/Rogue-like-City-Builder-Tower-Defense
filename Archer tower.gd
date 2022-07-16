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

func _ready():
	mod_change(3) #REMOVE ONCE CITIZEN ASSIGNING WORKS
#	line.add_point(global_position)
	yield(get_tree().create_timer(randf()),"timeout")
	while true:
		yield(get_tree().create_timer(attack_spd),"timeout")
		attackable = true

func _process(delta):
	attack_target()
#	line.remove_point(1) #scrapped for now.
#	if line != null and en_array.size() != 0:
#		line.add_point(target.global_position)

func attack_target():
	if mod != 0: #if no one is working here
		if attackable and en_array.size() != 0: #if the tree has an enemy and attack timer is up
			if AOE:
				attackable = false
				for x in en_array.size():
					en_array[x].damage(damage,type)
			else:
				en_array[0].damage(damage,type)
				attackable = false
				if removal:
					en_array.erase(0)

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
