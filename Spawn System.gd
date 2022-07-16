extends Node2D

var timer = 0
var reset = 20

const goblin = preload("res://Enemies/Black_Goblin.tscn")
const dog = preload("res://Enemies/Enemy_Base.tscn")
const hel_gob = preload("res://Enemies/Hellmet goblin.tscn")
const shellmet = preload("res://Enemies/shellmet.tscn")

func _ready():
	print("wave1")
	timer = reset
	make_enemy(goblin,3)
	yield(get_tree().create_timer(20),"timeout")
	print("wave2")
	make_enemy(goblin,5)
	yield(get_tree().create_timer(20),"timeout")
	print("wave3")
	make_enemy(goblin,3)
	make_enemy(dog,2)

func make_enemy(preset,number):
	for x in number:
		var enemy = preset.instance()
		enemy.global_position = global_position
		self.add_child(enemy)
		yield(get_tree().create_timer(0.3),"timeout")
