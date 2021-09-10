extends RigidBody2D

var shoot = true


# Called when the node enters the scene tree for the first time.
func _ready():
	shoot = true

func _process(delta):
	if global_position.x > 75 and shoot == true:
		position.x -= 200 * delta
	elif global_position.x > 25 and global_position.x < 75 and shoot == true:
		position.x -= 100 * delta
	else:
		position.x += 350 * delta
		shoot = false

# warning-ignore:unused_argument
func _on_HitArea_area_entered(area):
	queue_free()

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
