extends CanvasLayer

onready var tower_label = $towers
onready var wave_label = $wave
onready var dice = preload("res://Enemies/weapon dice.tscn")
onready var die = $Die
onready var health = $health
onready var dosh = $dosh


const large_cost = 35
const medium_cost = 15
const small_cost = 5

onready var win = $win

func _process(delta):
	if public.wave == 11:
		win.visible = true
	else:
		win.visible = false
	if public.roll != "":
		set_die(public.roll)
		public.roll = ""
	health.text = str(public.tower_hp)
	dosh.text = str(public.dosh)
	tower_label.text = str(towers)
	wave_label.text = str(public.wave)
	if public.tower_hp <= 0:
		audio.play("res://assets/noises/hitHurt.wav")
		public.lose = true
		get_tree().change_scene("res://MainMenu.tscn")

onready var towers = 0

func _on_gold_button_up():
	if public.dosh >= large_cost:
		audio.play("res://assets/noises/jump.wav")
		public.dosh -= large_cost
		var inst = dice.instance()
		inst.power = 3
		self.add_child(inst)
		towers += 1

func _on_silver_button_up():
	if public.dosh >= medium_cost:
		audio.play("res://assets/noises/jump (1).wav")
		public.dosh -= medium_cost
		var inst = dice.instance()
		inst.power = 2
		self.add_child(inst)
		towers += 1

func _on_bronze_button_up():
	if public.dosh >= small_cost:
		audio.play("res://assets/noises/jump (2).wav")
		public.dosh -= small_cost
		var inst = dice.instance()
		inst.power = 1
		self.add_child(inst)
		towers += 1

func set_die(roll):
	die.play(roll)
