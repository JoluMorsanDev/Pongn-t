extends KinematicBody2D

export var aceleration = 1800
export var max_speed = 1200
var motion = Vector2()
export var friction = 0.3
var y_input
var firstposx 
var state = "static"
onready var bar = owner.get_node_or_null("Bar")
export (PackedScene) var bomb
export (PackedScene) var bombcross
var life = 4
var inmunity = false
var up = false
var down = false
var bootswasted = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$Body.modulate = Color(1,1,1,1)
	$Body.visible = true
	if rand_range(0,1) > 0.5:
		y_input = -1
	else:
		y_input = 1
	firstposx = global_position.x
	state = "follow"
	aceleration = 1800
	max_speed = 1200
	$SpeedAnim/Boots.hide()
	$Body/Legs/Wheels.hide()

func _physics_process(delta):
	if $UParea/RayCast2D.is_colliding():
		up = true
	if $DownArea/RayCast2D.is_colliding():
		down = true
	global_position.x = firstposx
	if up == false and down == false:
		state = "static"
	else:
		state = "follow"
		if up == false and down == true:
			y_input = -1
		elif up == true and down == false:
			y_input = 1
		else:
			y_input = 0
	if state == "static":
		y_input = 0
	if y_input != 0 and state == "follow":
		motion.y += y_input * aceleration * delta
		motion.y = clamp(motion.y, -max_speed, max_speed)
		if global_position.y > 460:
			y_input = -1
		if global_position.y < 20:
			y_input = 1
	elif y_input == 0 and state == "follow":
		motion.y = lerp(motion.y, 0, friction)
	elif state == "static":
		pass
	elif state == "static":
		pass
	motion = move_and_slide(motion)

func bomb1gen():
	var bomb1 = bomb.instance()
	owner.add_child(bomb1)
	bomb1.global_position = Vector2(global_position.x, 50)
	var bomb2 = bomb.instance()
	owner.add_child(bomb2)
	bomb2.global_position = Vector2(global_position.x, 430)

func bomb2gen():
	var bomb1 = bombcross.instance()
	owner.add_child(bomb1)
	bomb1.global_position = global_position

# warning-ignore:unused_argument
func _on_HitArea_area_entered(area):
	if inmunity == false and area.owner.name != "Bombermen":
		life -= 1
		inmunity = true
		$IT.start()
		$Inmunity.play("Nueva Animación")
		if life == 2 and bootswasted == false:
			$SpeedAnim.play("Nueva Animación")
			bootswasted = true
		if life <= 0:
			queue_free()

func _on_IT_timeout():
	$Inmunity.stop()
	$Body.visible = true
	$Body.modulate = Color(1,1,1,1)
	inmunity = false

# warning-ignore:unused_argument
func _on_UParea_area_entered(area):
	up = true

# warning-ignore:unused_argument
func _on_UParea_area_exited(area):
	up = false

# warning-ignore:unused_argument
func _on_DownArea_area_entered(area):
	down = true

# warning-ignore:unused_argument
func _on_DownArea_area_exited(area):
	down = false

func _on_Bombtimer_timeout():
	if rand_range(0,1) > 0.5:
		bomb1gen()
	else:
		bomb2gen()
	$Bombtimer.wait_time = rand_range(1.5,2.5)
	$Bombtimer.start()

func _on_SpeedAnim_animation_finished(anim_name):
	life += 1
