extends Node2D

var life = 3
var screenshake = false

# Called when the node enters the scene tree for the first time.
func _ready():
	screenshake = false

# warning-ignore:unused_argument
func _process(delta):
	if Input.is_action_pressed("ui_select"):
# warning-ignore:return_value_discarded
		get_tree().reload_current_scene()
	if life >= 0:
		$LifeLabel.text = "Life: " + str(get_node_or_null("WesternGame").get_node("WesternBoi").life)
		

func _on_Ball_hit():
	if life > 0:
		life -= 1
		if screenshake == false:
			camdown()
			screenshake = true
			$ScreenShakeTimer.start()

func camup():
	if screenshake == true:
		$MainCam.global_position.y = 250
		$MainCam.global_rotation_degrees = 1
		yield(get_tree().create_timer(.1),"timeout")
		camdown()

func camdown():
	if screenshake == true:
		$MainCam.global_position.y = 230
		$MainCam.global_rotation_degrees = -1
		yield(get_tree().create_timer(.1),"timeout")
		camup()

func _on_ScreenShakeTimer_timeout():
	screenshake = false
	$MainCam.global_position.y = 240
	$MainCam.global_rotation_degrees = 0
