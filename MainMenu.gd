extends Control

func _ready():
	public.lose = false

func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		public.lose = false
		public.dosh = 10
		public.tower_hp = 10
		public.wave = 0
		get_tree().change_scene("res://main.tscn")


func _on_Button_button_up():
	public.lose = false
	public.dosh = 10
	public.tower_hp = 10
	public.wave = 0
	get_tree().change_scene("res://main.tscn")

