extends Node2D

var life = 3
var screenshake = false
onready var sctimer = Timer.new()


# Called when the node enters the scene tree for the first time.
func _ready():
	$Balls/Ball.velocity.x = -$Balls/Ball.speed
	screenshake = false
	sctimer.wait_time = 0.2
	sctimer.one_shot = true
	add_child(sctimer)
	sctimer.connect("timeout", self, "_on_ScreenShakeTimer_timeout")

# warning-ignore:unused_argument
func _process(delta):
	if Input.is_action_pressed("ui_select"):
# warning-ignore:return_value_discarded
		get_tree().reload_current_scene()
	if life >= 0:
		$LifeLabel.text = "Life: " + str(life)
	
		

func _on_Ball_hit():
	$Bar.position.y = 239.962
	if life > 0:
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
	screenshake = false
	$MainCam.global_position.y = 240
	$MainCam.global_rotation_degrees = 0
	$ColorRect.color = Color(0, 0, 0, 0)

func game_over():
	get_tree().paused = true
	$MainCam/Gameoverui.show()

func win():
	Singletones.levelsunlocked = 3
	Singletones.save_levels_unlocked()
	get_tree().paused = false
	$MainCam/winUI.show()

func _on_Bar_hit():
	_on_Ball_hit()

func _on_JumpManGame_hit():
	$Balls/Ball.boss_hit()
	$JumpManGame/Jumpman/Body/Damage.hide()
	$JumpManGame/StunTimer.stop()
	$JumpManGame/Jumpman/Area2D/CollisionPolygon2D.set_deferred("disabled", false)
	$Bar.position.y = 239.962
