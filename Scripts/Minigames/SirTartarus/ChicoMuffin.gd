extends KinematicBody2D

export var aceleration = 800
export var max_speed = 500
var motion = Vector2()
export var friction = 0.3
var y_input
var firstposx 
var state = "static"
onready var bar = owner.get_node_or_null("Bar")
export (PackedScene) var Pickaxe
var pick_ammo = 2
export (PackedScene) var fly
var tank = true
var life = 3
onready var tankobj = get_node_or_null("Tank")

# Called when the node enters the scene tree for the first time.
func _ready():
	y_input = 0
	firstposx = global_position.x
	state = "follow"

func _physics_process(delta):
	if tankobj != null:
		tank = true
	else:
		tank = false
	global_position.x = firstposx
	if state == "static":
		y_input = 0
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
	match pick_ammo:
		0:
			$Pickaxes/first.hide()
			$Pickaxes/second.hide()
		1:
			$Pickaxes/first.show()
			$Pickaxes/second.hide()
		2:
			$Pickaxes/first.show()
			$Pickaxes/second.show()

# warning-ignore:unused_argument
func _on_PickaxeArea_area_entered(area):
	match pick_ammo:
		0:
			pick_ammo = 1
		1:
			pick_ammo = 2


func _on_Pickaxe_Timer_timeout():
	if pick_ammo > 0:
		var pick = Pickaxe.instance()
		add_child(pick)
		pick.global_position = Vector2(global_position.x - 150, global_position.y)
