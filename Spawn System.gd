extends Node2D

var timer = 0
var reset = 20

export var on = true
const goblin = preload("res://Enemies/Black_Goblin.tscn")
const dog = preload("res://Enemies/Enemy_Base.tscn")
const hel_gob = preload("res://Enemies/Hellmet goblin.tscn")
const shellmet = preload("res://Enemies/shellmet.tscn")
const summoner = preload("res://Enemies/summoner.tscn") #MINI BOSSES
const dave = preload("res://Enemies/dark_dwarf.tscn")

var wave
func _ready():
	wave = 0
	if on:
		yield(get_tree().create_timer(20),"timeout")
		wave = 1
		timer = reset
		man(goblin,3,0.4)
		yield(get_tree().create_timer(20),"timeout")
		wave = 2
		man(goblin,5,0.2)
		yield(get_tree().create_timer(20),"timeout")
		wave = 3
		man(goblin,3,0.3)
		man(dog,2,1)
		yield(get_tree().create_timer(20),"timeout")
		wave = 4
		man(goblin,9,0.15)
		yield(get_tree().create_timer(20),"timeout")
		wave = 5
		man(summoner,1,0)
		man(dog,2,0.5)
	

func man(preset,number,compression):# make enemy, lower is more compressed
	for x in number:
		var enemy = preset.instance()
		enemy.global_position = global_position
		self.add_child(enemy)
		yield(get_tree().create_timer(compression),"timeout")
