extends MarginContainer

func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		get_tree().change_scene("res://main.tscn")
		public.dosh = 10
		public.tower_hp = 10
		public.wave = 0
