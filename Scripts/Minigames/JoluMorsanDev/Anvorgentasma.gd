extends RigidBody2D

export var speed = 250
onready var bar = get_parent().owner.get_node_or_null("Bar")
var target

func _ready():
	target = bar.global_position.y

func _physics_process(delta):
	if global_position.y - target > 5:
		position.y -= .5*speed*delta
	elif global_position.y - target < -5:
		position.y += .5*speed*delta
	position.x -= speed * delta
	global_position.y = clamp(global_position.y, 0, 480)


# warning-ignore:unused_argument
func _on_HitArea_area_entered(area):
	queue_free()

func _on_Node2D_screen_exited():
	queue_free()
