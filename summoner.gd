extends KinematicBody2D #exact copy of enemy script, summons every 10 seconds

onready var sprite = $AnimatedSprite
onready var particle = $CPUParticles2D
export var hp = 10.0 
export var spd = 60
export var dmg = 1.0
export var bomber = false #dies on contact.
export var atk_range = 100.0 
export var value = 5
var spd1 = spd
var velo = Vector2.ZERO
var effect_time = 0.0

var path : Array = [] 
var level_nav = null
var hearth = null

var dmg_mod = 1.0
var DOT = 0 #Damage Over Time

onready var bar = $ProgressBar
onready var anim = $AnimatedSprite

func damage(dmg,mod):
	hp -= (dmg * dmg_mod)
	if hp <= 0: #if health is lower than 0, remove self.
		public.dosh += value
		queue_free()
	print(hp)
	particle.emitting = true # Extremely rudementary particle system.
	match mod:
		"fire":
			DOT = .008
		"acid":
			dmg_mod = 1.5 #50% more damage
		"ice":
			spd = spd1 * 0.8

export onready var dog = preload("res://Enemies/Enemy_Base.tscn")

func _ready():
	bar.max_value = hp
	yield(get_tree(), "idle_frame")
	var tree = get_tree()
	if tree.has_group("nav"):
		level_nav = tree.get_nodes_in_group("nav")[0]
	if tree.has_group("hearth"):
		hearth = tree.get_nodes_in_group("hearth")[0]
	while true:
		yield(get_tree().create_timer(9),"timeout")
		anim.play("summon")
		yield(get_tree().create_timer(1),"timeout")
		for x in 3:
			randomize()
			var inst = dog.instance()
			inst.position.x = rand_range(-150,150)
			inst.position.y = rand_range(-150,100)
			get_tree().root.add_child(inst)


func _physics_process(delta):
	if anim.frame == 9:
		anim.play("run")
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
			pass #ATTACK

func generate_path():
	if hearth != null and level_nav != null:
		path = level_nav.get_simple_path(global_position, hearth.global_position, false)

func move():
	if hearth and anim.animation == "run":
		if global_position.distance_to(hearth.global_position) >= atk_range:
			velo = move_and_slide(velo)
			if velo.x > 0:
				sprite.flip_h = false
			else:
				sprite.flip_h = true
