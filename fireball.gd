extends KinematicBody2D

onready var anim = $fireball
onready var expl = preload("res://Enemies/explotion.tscn")

func _process(delta):
	match anim.animation:
		"arrow":
			if anim.frame == 6:
				queue_free()

var velocity = Vector2()
var speed = 700

func _physics_process(delta):
	look_at(target)
	velocity = Vector2(speed, 0).rotated(rotation)
	velocity = move_and_slide(velocity)
	if global_position.distance_to(target) <= 10.0:
		if anim.animation == "fireball":
			var inst = expl.instance()
			inst.global_position = global_position
			get_tree().root.add_child(inst)
		queue_free()

func animation(path):
	$fireball.animation = path

var target = Vector2(0,0)
