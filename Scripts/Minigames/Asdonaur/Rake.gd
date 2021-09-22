extends RigidBody2D

export var speed = 500

func _physics_process(delta):
	position -= speed * delta * -transform.x
	global_position.y = clamp(global_position.y, 0, 480)

# warning-ignore:unused_argument
func _on_HitArea_area_entered(area):
	queue_free()

func _on_Node2D_screen_exited():
	queue_free()
