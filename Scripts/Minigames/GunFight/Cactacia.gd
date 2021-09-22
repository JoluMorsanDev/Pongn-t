extends RigidBody2D

var dir = 1
var speed = 75

func _process(delta):
	position.y += dir * speed * delta

func _on_VisibilityNotifier2D_screen_exited():
	dir = -dir
