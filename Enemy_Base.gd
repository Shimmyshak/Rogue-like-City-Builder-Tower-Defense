extends KinematicBody2D

onready var sprite = $AnimatedSprite
onready var particle = $CPUParticles2D
export var hp = 10.0 
export var spd = 60
export var dmg = 1
export var bomber = false #dies on contact.
export var atk_range = 100.0 
var spd1 = spd
var velo = Vector2.ZERO
var effect_time = 0.0

var path : Array = [] 
var level_nav = null
var hearth = null # set to town location

var dmg_mod = 1.0
var DOT = 0 #Damage Over Time
func damage(dmg,mod):
	hp -= dmg
	if hp <= 0: #if health is lower than 0, remove self.
		queue_free()
	print(hp)
	particle.emitting = true # Extremely rudementary particle system.
	match mod:
		"fire":
			DOT = .008
		"acid":
			dmg_mod = 1.3 #30% more damage
		"ice":
			spd = spd1 * 0.8
	

func _ready():
	yield(get_tree(), "idle_frame")
	var tree = get_tree()
	if tree.has_group("nav"):
		level_nav = tree.get_nodes_in_group("nav")[0]
	if tree.has_group("hearth"):
		hearth = tree.get_nodes_in_group("hearth")[0]

func _physics_process(delta):
	if DOT != 0:
		damage(DOT,"") #pretty terible solution.
	if hearth and level_nav: #aren't null
		generate_path()
		navigate()
	move()
	

func navigate():
	if path.size() > 0:
		if global_position.distance_to(hearth.global_position) >= atk_range:
			velo = global_position.direction_to(path[1]) * spd
			#if destination reached, remove path.
			if global_position == path[0]:
				path.pop_front() 
		else:
			pass #ATTACK

func generate_path():
	if hearth != null and level_nav != null:
		path = level_nav.get_simple_path(global_position, hearth.global_position, false)

func move():
	if hearth:
		if global_position.distance_to(hearth.global_position) >= atk_range:
			velo = move_and_slide(velo)
			if velo.x > 0:
				sprite.flip_h = false
			else:
				sprite.flip_h = true


