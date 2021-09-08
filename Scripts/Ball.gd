extends KinematicBody2D

var speed = 500
var velocity = Vector2()
var firstc = true
var firstpos 
export var rotational = 3.5
onready var lastpos = position

signal hit

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
		Singletones.play_bounce()
		#$Bounce.play()
		velocity = velocity.bounce(collision.normal)
		if firstc == true:
			velocity = Vector2(speed, 0).rotated(rotational)
			firstc = false


func _on_VisibilityNotifier2D_screen_exited():
	rotational = rand_range(3.5, 4)
	$Sprite.rotation_degrees = -rotational
	start(rotational)
	firstc = true
	global_position = firstpos
	velocity.x = -speed 
	emit_signal("hit")

func boss_hit():
	rotational = rand_range(3.5, 4)
	$Sprite.rotation_degrees = -rotational
	start(rotational)
	firstc = true
	global_position.x = firstpos.x
	global_position.y = owner.get_node("Bar").global_position.y
	velocity.x = -speed 


func _on_ComprobarMove_timeout():
	if lastpos.x - position.x == 0 or lastpos.y - position.y == 0:
		boss_hit()
	lastpos = position
