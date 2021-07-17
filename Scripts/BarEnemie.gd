extends KinematicBody2D

#declarar variables
export var aceleration = 300
export var max_speed = 400
var motion = Vector2()
export var friction = 1
var y_input
var state = "normal"
var firstposx 

#obtiene la input de movimiento
func get_input():
	pass

# Called when the node enters the scene tree for the first time.
func _ready():
	y_input = 0
	state = "follow"
	firstposx = global_position.x

# warning-ignore:unused_argument
func _physics_process(delta):
	global_position.x = firstposx
	if state == "normal":
		y_input = 0
	elif state == "follow":
		if get_parent().get_node_or_null("Balls").get_node_or_null("Ball") != null:
			if get_parent().get_node_or_null("Balls").get_node_or_null("Ball").global_position.y - global_position.y > 10:
				y_input = 1
			elif get_parent().get_node_or_null("Balls").get_node_or_null("Ball").global_position.y - global_position.y < -10:
				y_input = -1
			elif get_parent().get_node_or_null("Balls").get_node_or_null("Ball").global_position.y - global_position.y > -10 and get_parent().get_node_or_null("Balls").get_node_or_null("Ball").global_position.y - global_position.y < 10:
				y_input = 0
	if y_input != 0:
		motion.y += y_input * aceleration * get_physics_process_delta_time()
		motion.y = clamp(motion.y, -max_speed, max_speed)
		if global_position.y > 460:
			y_input = -1
		if global_position.y < 20:
			y_input = 1
	else:
		motion.y = lerp(motion.y, 0, friction)
	motion = move_and_slide(motion)

# warning-ignore:unused_argument
func _on_Area2D_body_entered(body):
	$AnimationPlayer.play("destroy")



# warning-ignore:unused_argument
func _on_Area2D_area_entered(area):
	$AnimationPlayer.play("destroy")
