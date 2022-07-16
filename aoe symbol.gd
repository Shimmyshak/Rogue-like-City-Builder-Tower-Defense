extends AnimatedSprite


func _ready():
	yield(get_tree().create_timer(0.8),"timeout")
	queue_free()
