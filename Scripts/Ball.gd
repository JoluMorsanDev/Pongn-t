extends KinematicBody2D

var item_id = int()
var speed = 500
var speedscale = 1
var velocity = Vector2()
var firstc = true
var firstpos 
export var rotational = 3.5
onready var lastpos = position
export (PackedScene) var Shield

signal hit
signal heal

func _ready():
	randomize()
	rotational = rand_range(3.5, 4)
	$Sprite.rotation_degrees = -rotational
	firstpos = global_position
	velocity.x = speed
	start(rotational)


func start(dir):
	rotation_degrees = dir
	velocity = Vector2(speed*speedscale, 0).rotated(rotation)

func _physics_process(delta):
	var collision = move_and_collide(velocity * delta * speedscale)
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
	speedscale = 1
	$SpeedTimer.stop()

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


func _on_ItemArea_body_entered(area):
	match area.item_id:
		0:
			emit_signal("heal")
		1:
			speedscale = 1.5
			$SpeedTimer.stop()
			$SpeedTimer.start()
		2:
			speedscale = .5
			$SpeedTimer.stop()
			$SpeedTimer.start()
		3:
			if owner.get_node("Bar").get_node_or_null("shield") == null:
				var shield = Shield.instance()
				owner.get_node("Bar").add_child(shield)
				shield.name = "shield"
				shield.global_position = owner.get_node("Bar").global_position

func _on_SpeedTimer_timeout():
	speedscale = 1
