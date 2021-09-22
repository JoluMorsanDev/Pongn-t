extends KinematicBody2D

#declarar variables
export var aceleration = 800*1.5
export var max_speed = 500*1.5
var motion = Vector2()
export var friction = 0.3
var firstposx
var y_input = 0
var inmunity = false

signal hit

#obtiene la input de movimiento
func get_input():
	pass

# Called when the node enters the scene tree for the first time.
func _ready():
	firstposx = global_position.x

# warning-ignore:unused_argument
func _physics_process(delta):
	global_position.x = firstposx
	y_input = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	if y_input != 0:
		motion.y += y_input * aceleration * get_physics_process_delta_time()
		motion.y = clamp(motion.y, -max_speed, max_speed)
	else:
		motion.y = lerp(motion.y, 0, friction)
	motion = move_and_slide(motion)


# warning-ignore:unused_argument
func _on_HitArea_area_entered(area):
	if inmunity == false and area.name != "shield":
		emit_signal("hit")
		inmunity = true
		$InmunityTimer.start()

func _on_InmunityTimer_timeout():
	inmunity = false
