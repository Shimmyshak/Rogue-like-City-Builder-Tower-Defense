extends CanvasLayer

onready var dice = preload("res://Enemies/weapon dice.tscn")
onready var health = $health
onready var dosh = $dosh

const large_cost = 45
const medium_cost = 15
const small_cost = 5

func _process(delta):
	health.text = str(public.tower_hp)
	dosh.text = str(public.dosh)

func _on_gold_button_up():
	if public.dosh >= large_cost:
		public.dosh -= large_cost
		var inst = dice.instance()
		inst.power = 3
		self.add_child(inst)

func _on_silver_button_up():
	if public.dosh >= medium_cost:
		public.dosh -= medium_cost
		var inst = dice.instance()
		inst.power = 2
		self.add_child(inst)

func _on_bronze_button_up():
	if public.dosh >= small_cost:
		public.dosh -= small_cost
		var inst = dice.instance()
		inst.power = 1
		self.add_child(inst)
