extends RigidBody2D

func _physics_process(delta):
	position.x -= 250 * delta
	global_position.y = clamp(global_position.y, 0, 480)


# warning-ignore:unused_argument
func _on_HitArea_area_entered(area):
	queue_free()

func _on_Node2D_screen_exited():
	queue_free()
