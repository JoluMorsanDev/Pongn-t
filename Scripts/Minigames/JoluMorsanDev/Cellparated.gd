extends KinematicBody2D

var speed = 600
var speedscale = 1
var velocity = Vector2()
var firstc = true
var firstpos 
export var rotational = 3.5
onready var lastpos = position

func _ready():
	randomize()
	rotational = rand_range(-3, 3)
	$Sprite.rotation_degrees = -rotational
	firstpos = global_position
	velocity.x = speed
	start(rotational)

func start(dir):
	rotation_degrees = dir + rand_range(-90,270)
	velocity = Vector2(-speed*speedscale, 0).rotated(rotation)

func _physics_process(delta):
	var collision = move_and_collide(velocity * delta * speedscale)
	if collision:
		Singletones.play_bounce()
		velocity = velocity.bounce(collision.normal)
		if firstc == true:
			velocity = Vector2(speed, 0).rotated(rotational)
			firstc = false

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

# warning-ignore:unused_argument
func _on_EnemyHitArea_area_entered(area):
	if area.name == "CellHit":
		queue_free()

