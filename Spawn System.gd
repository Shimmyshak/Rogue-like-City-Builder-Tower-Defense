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
const big_dog = preload("res://Enemies/big_dog.tscn")
const gold = preload("res://Enemies/gold_gob.tscn")

var wave
func _ready():
	wave = 0
	if on:
		yield(get_tree().create_timer(10),"timeout")
		public.wave = 1
		timer = reset
		man(goblin,3,0.4)
		audio.play("res://assets/noises/explosion.wav")
		yield(get_tree().create_timer(15),"timeout")
		public.wave = 2
		man(goblin,6,0.4)
		audio.play("res://assets/noises/explosion.wav")
		man(dog,1,0)
		yield(get_tree().create_timer(15),"timeout")
		public.wave = 3
		man(goblin,5,0.3)
		audio.play("res://assets/noises/explosion.wav")
		man(dog,4,1)
		yield(get_tree().create_timer(15),"timeout")
		public.wave = 4
		audio.play("res://assets/noises/explosion.wav")
		man(summoner,1,0.15)
		man(gold,1,0)
		yield(get_tree().create_timer(15),"timeout")
		public.wave = 5# First Boss Wave
		audio.play("res://assets/noises/explosion.wav")
		man(dave,2,1)
		yield(get_tree().create_timer(15),"timeout")
		public.wave = 6
		audio.play("res://assets/noises/explosion.wav")
		man(shellmet,10,1)
		yield(get_tree().create_timer(15),"timeout")
		public.wave = 7
		audio.play("res://assets/noises/explosion.wav")
		man(summoner,3,0.2)
		man(dog,4,0.5)
		yield(get_tree().create_timer(15),"timeout")
		public.wave = 8
		man(summoner,2,0)
		audio.play("res://assets/noises/explosion.wav")
		man(goblin,8,0.5)
		yield(get_tree().create_timer(15),"timeout")
		public.wave = 9
		man(summoner,1,0)
		audio.play("res://assets/noises/explosion.wav")
		man(dave,3,0.3)
		yield(get_tree().create_timer(15),"timeout")
		public.wave = 10
		audio.play("res://assets/noises/explosion.wav")
		man(big_dog,6,1)
		yield(get_tree().create_timer(15),"timeout")
		public.wave = 11
	
func man(preset,number,compression):# make enemy, lower is more compressed
	for x in number:
		var enemy = preset.instance()
		enemy.global_position = global_position
		self.add_child(enemy)
		yield(get_tree().create_timer(compression),"timeout")
