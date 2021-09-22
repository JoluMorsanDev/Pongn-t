extends KinematicBody2D

export var aceleration = 1800
export var max_speed = 1200
var motion = Vector2()
export var friction = 0.3
var y_input
var firstposx 
var state = "static"
var life = 5
var inmunity = false
var up = false
var down = false
export (PackedScene) var Saw
export (PackedScene) var Logs
export (PackedScene) var Anvorgentasma
export (PackedScene) var Cell

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
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

func sawgen():
	var saw = Saw.instance()
	owner.call_deferred("add_child", saw)
	saw.global_position = Vector2(global_position.x-75, rand_range(50,215))
	var saw2 = Saw.instance()
	owner.call_deferred("add_child", saw2)
	saw2.global_position = Vector2(global_position.x-75, rand_range(265,430))
	pass

func loggen():
	var logs = Logs.instance()
	owner.call_deferred("add_child", logs)
	logs.global_position = Vector2(720, rand_range(-100,100))
	pass

func cellgen():
	var cell = Cell.instance()
	owner.call_deferred("add_child", cell)
	cell.global_position = global_position
	pass

func anvorgentasmagen():
	var anvorgentasma = Anvorgentasma.instance()
	owner.call_deferred("add_child", anvorgentasma)
	anvorgentasma.global_position = global_position
	pass

# warning-ignore:unused_argument
func _on_HitArea_area_entered(area):
	if inmunity == false and area.owner.name != "Jolumorsan12347":
		life -= 1
		inmunity = true
		$IT.start()
		$Inmunity.play("Nueva Animación")
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

func _on_Atk_animation_finished(anim_name):
	match int(rand_range(0,4)):
		0:
			$Atk.play("idle")
		1:
			$Atk.play("cellparation")
		2:
			$Atk.play("gherost")
		3:
			$Atk.play("huevoman")
		4:
			$Atk.play("gherost")
		5:
			$Atk.play("cellparation")
		6:
			$Atk.play("huevoman")
