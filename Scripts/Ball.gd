extends KinematicBody2D

var speed = 500
var velocity = Vector2()
var firstc = true
var firstpos 
export var rotational = 3.5

func _ready():
	randomize()
	rotational = rand_range(3.5, 4)
	$Sprite.rotation_degrees = -rotational
	firstpos = global_position
	velocity.x = speed
	start(rotational)

func start(dir):
	rotation_degrees = dir
	velocity = Vector2(speed, 0).rotated(rotation)

func _physics_process(delta):
	var collision = move_and_collide(velocity * delta)
	if collision:
		velocity = velocity.bounce(collision.normal)
		if firstc == true:
			velocity = Vector2(speed, 0).rotated(rotational)
			firstc = false


func _on_VisibilityNotifier2D_screen_exited():
	rotational = rand_range(3.5, 4)
	$Sprite.rotation_degrees = -rotational
	global_position = firstpos
	velocity.x = speed 
	start(rotational)
	firstc = true
