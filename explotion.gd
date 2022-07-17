extends AnimatedSprite


func _process(delta):
	match animation:
		"fire":
			if frame == 7:
				queue_free()
		"":
			if frame == null:
				queue_free()
