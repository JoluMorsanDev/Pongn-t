extends RigidBody2D

export var speed = 250

func _ready():
	randomize()
	global_rotation_degrees = rand_range(-22.5, 22.5)
	$Sprite.global_rotation_degrees = 0

func _physics_process(delta):
	position -= speed * delta * transform.x
	global_position.y = clamp(global_position.y, 0, 480)


func _on_Node2D_screen_exited():
	queue_free()
