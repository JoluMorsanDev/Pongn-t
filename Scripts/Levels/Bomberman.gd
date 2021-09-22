extends Node2D

var life = 3
var screenshake = false
onready var sctimer = Timer.new()


# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().paused = false
	$Balls/Ball.velocity.x = -$Balls/Ball.speed
	screenshake = false
	sctimer.wait_time = 0.3
	sctimer.one_shot = true
	add_child(sctimer)
	sctimer.connect("timeout", self, "_on_ScreenShakeTimer_timeout")

# warning-ignore:unused_argument
func _process(delta):
	if get_node_or_null("Bombermen/Bomberboi") == null:
		win()
	else:
		$TankLifeLabel.text = "B. M. Life: " + str(get_node_or_null("Bombermen/Bomberboi").life)
	if Input.is_action_pressed("ui_select"):
# warning-ignore:return_value_discarded
		get_tree().reload_current_scene()
	if life >= 0:
		$LifeLabel.text = "Life: " + str(life)

func _on_Ball_hit():
	Singletones.play_hit()
	$Bar.position.y = 239.962
	if life > 1:
		life -= 1
		if screenshake == false:
			screenshake = true
			sctimer.start()
			camdown()
	else:
		game_over()

func camup():
	if screenshake == true:
		$MainCam.global_position.y = 245
		$MainCam.global_rotation_degrees = 5
		yield(get_tree().create_timer(.1),"timeout")
		$ColorRect.color = Color(0, 0, 0, 0)
		camdown()

func camdown():
	if screenshake == true:
		$MainCam.global_position.y = 235
		$MainCam.global_rotation_degrees = -5
		yield(get_tree().create_timer(.1),"timeout")
		$ColorRect.color = Color(1, 1, 1, 0)
		camup()

func _on_ScreenShakeTimer_timeout():
	set_deferred("screenshake", false)
	$MainCam.global_position.y = 240
	$MainCam.global_rotation_degrees = 0
	$ColorRect.color = Color(0, 0, 0, 0)

func game_over():
	screenshake = false
	$MainCam.global_position.y = 240
	$MainCam.global_rotation_degrees = 0
	$ColorRect.color = Color(0, 0, 0, 0)
	get_tree().paused = true
	$MainCam/GameOverUI.show()

func win():
	screenshake = false
	$MainCam.global_position.y = 240
	$MainCam.global_rotation_degrees = 0
	$ColorRect.color = Color(0, 0, 0, 0)
	if Singletones.selectorlevelsunlocked == 4:
		Singletones.selectorlevelsunlocked = 5
	Singletones.levelsunlocked = 5
	Singletones.save_levels_unlocked()
	get_tree().paused = true
	$MainCam/winUI.show()

func _on_Bar_hit():
	_on_Ball_hit()

func _on_Ball_heal():
	life += 1
	life = clamp(life, 0, 3)
