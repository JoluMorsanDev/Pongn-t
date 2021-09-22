extends KinematicBody2D

var speed = 500
var speedscale = 1
var velocity = Vector2()
var firstc = true
var firstpos 
export var rotational = 3.5
onready var lastpos = position
export (PackedScene) var Cellparated

func _ready():
	randomize()
	rotational = rand_range(3, 4)
	$Sprite.rotation_degrees = -rotational
	firstpos = global_position
	velocity.x = speed
	start(rotational)

func start(dir):
	rotation_degrees = dir-90
	velocity = Vector2(speed*speedscale, 0).rotated(rotation)

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
	if area.name != "EnemyHitArea":
		queue_free()


func cellparated_gen():
	var Cell1 = Cellparated.instance()
	get_parent().add_child(Cell1)
	Cell1.global_position = $Sprite/Cell1pos.global_position
	var Cell2 = Cellparated.instance()
	get_parent().add_child(Cell2)
	Cell2.global_position = $Sprite/Cell2pos.global_position
	queue_free()

# warning-ignore:unused_argument
func _on_BallHitArea_body_entered(body):
	$AnimationPlayer.play("Nueva Animación")
