extends KinematicBody2D #exact copy of enemy script, summons every 10 seconds

onready var sprite = $AnimatedSprite
export var hp = 10.0 
export var spd = 60
export var dmg = 1.0
export var bomber = false #dies on contact.
export var atk_range = 100.0 
export var value = 1.0
export var resistance = 1.0
var spd1 = 1
var velo = Vector2.ZERO
var effect_time = 0.0

var path : Array = [] 
var level_nav = null
var hearth = null

var dmg_mod = 1.0
var DOT = 0 #Damage Over Time

onready var bar = $progressbar

var stop = 1.0 #ice
var ouch = 0.0 #acid
var burn = 0.0 #fire
func damage(dmg,mod):
	hp -= (dmg * dmg_mod)
	if hp <= 0: #if health is lower than 0, remove self.
		public.dosh += value
		audio.play("res://assets/noises/pickupCoin (1).wav")
		queue_free()
	match mod:
		"fire": #poison, actully
			DOT = .008
			burn = 5.0 #lasts 5 seconds
			
		"acid": 
			dmg_mod = 1.5 #50% more damage
			ouch = 5.0
		"ice":
			spd = spd1
			spd *= 0.6
			stop = 5
	

func _ready():
	bar.max_value = hp
	yield(get_tree(), "idle_frame")
	var tree = get_tree()
	if tree.has_group("nav"):
		level_nav = tree.get_nodes_in_group("nav")[0]
	if tree.has_group("hearth"):
		hearth = tree.get_nodes_in_group("hearth")[0]
	spd1 = spd

onready var curse = $curseparticle
onready var fire = $fire

func _physics_process(delta):
	if public.lose:
		queue_free()
	stop -= delta * resistance
	burn -= delta * resistance
	ouch -= delta * resistance
	if stop <= 0:
		spd = spd1
	if burn <= 0:
		DOT = 0
	if ouch <= 0:
		dmg_mod = 1.0
	if ouch >= 0 and curse != null:
		curse.emitting = true
	elif curse != null:
		curse.emitting = false
	if burn >= 0 and fire:
		fire.emitting = true
	elif fire != null:
		fire.emitting = false
	
	bar.value = hp
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
			public.tower_hp -= dmg
			queue_free() #match with bomber, not yet,

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
