extends KinematicBody2D

#declarar variables
export var aceleration = 600
export var max_speed = 300
var motion = Vector2()
export var friction = 0.3
var y_input
var state = "normal"

#obtiene la input de movimiento
func get_input():
	pass

# Called when the node enters the scene tree for the first time.
func _ready():
	y_input = 0
	state = "normal"

# warning-ignore:unused_argument
func _physics_process(delta):
	if state == "normal":
		y_input = 0
	elif state == "follow":
		if get_parent().get_node_or_null("Ball") != null:
			if get_parent().get_node_or_null("Ball").global_position.y - global_position.y > 0:
				motion.y = 1
			elif get_parent().get_node_or_null("Ball").global_position.y - global_position.y < 0:
				motion.y = -1
			elif get_parent().get_node_or_null("Ball").global_position.y - global_position.y == 0:
				motion.y = 0
	if y_input != 0:
		motion.y += y_input * aceleration * get_physics_process_delta_time()
		motion.y = clamp(motion.y, -max_speed, max_speed)
	else:
		motion.y = lerp(motion.y, 0, friction)
	motion = move_and_slide(motion)

# warning-ignore:unused_argument
func _on_Area2D_body_entered(body):
	state = "follow"

# warning-ignore:unused_argument
func _on_Area2D_body_exited(body):
	state = "normal"
