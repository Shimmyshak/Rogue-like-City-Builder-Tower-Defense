extends AnimatedSprite


func _process(delta):
	match animation:
		"ice":
			if frame == 7:
				queue_free()
		"poison":
			if frame == 16:
				queue_free()
		"hex":
			if frame == 15:
				queue_free()
