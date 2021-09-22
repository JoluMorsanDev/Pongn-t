extends KinematicBody2D

export var aceleration = 600
export var max_speed = 400
var motion = Vector2()
export var friction = 0.3
var y_input
var firstposx 
export var state = "static"
onready var bar = owner.owner.get_node_or_null("Bar")
export (PackedScene) var Flour
export (PackedScene) var Karbon
export(PackedScene)var Rake
var tank = true
var life = 5
var inmunity = false
# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	y_input = 0
	firstposx = global_position.x
	state = "follow"

func _physics_process(delta):
	global_position.x = firstposx
	if state == "static":
		y_input = 0
		motion.y = lerp(motion.y, 0, friction)
	elif state == "follow":
		if bar != null:
			if bar.global_position.y - global_position.y > 35:
				y_input = 1
			elif bar.global_position.y - global_position.y < -35:
				y_input = -1
			elif bar.global_position.y - global_position.y > -35 and bar.global_position.y - global_position.y < 35:
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

func flourgen():
	var flour1 = Flour.instance()
	owner.add_child(flour1)
	flour1.global_position = Vector2(720,rand_range(40,200))
	var flour2 = Flour.instance()
	owner.add_child(flour2)
	flour2.global_position = Vector2(720,rand_range(280,440))

func karbongen():
	if get_node_or_null("karbon") == null:
		var karbon = Karbon.instance()
		add_child(karbon)
		karbon.name = "karbon"
		karbon.global_position = $Karbonpos.global_position

func rakegen():
	var rake = Rake.instance()
	owner.add_child(rake)
	rake.global_position = $Karbonpos.global_position

# warning-ignore:unused_argument
func _on_HitArea_area_entered(area):
	if inmunity == false:
		life -= 1
		inmunity = true
		$Inmunity.play("Nueva Animación")
		$It.start()
	if life <= 0:
		queue_free()


func _on_ChangeTimer_timeout():
	match int(rand_range(0,5)):
		1:
			$Attacks.stop()
			if get_node_or_null("karbon") != null:
				get_node_or_null("karbon").queue_free()
		2:
			$Attacks.play("flour")
			if get_node_or_null("karbon") != null:
				get_node_or_null("karbon").queue_free()
		3:
			karbongen()
		4:
			rakegen()
			if get_node_or_null("karbon") != null:
				get_node_or_null("karbon").queue_free()
		5:
			_on_ChangeTimer_timeout()


func _on_It_timeout():
	$Inmunity.stop()
	$Body.modulate = Color(1,1,1,1)
	inmunity = false
