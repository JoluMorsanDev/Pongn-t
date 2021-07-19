extends KinematicBody2D

#declarar variables
export var aceleration = 800
export var max_speed = 500
var motion = Vector2()
export var friction = 0.3
export (PackedScene) var Bullet 
var y_input
var firstposx 
var bullets = 3
var state = "static"
var life = 3
var inmunity = true
onready var bar = owner.owner.get_node_or_null("Bar")

func _ready():
	life = 3
	y_input = 0
	firstposx = global_position.x
	state = "follow"

# warning-ignore:unused_argument
func _physics_process(delta):
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
		$AnimationPlayer.play("walk")
		motion.y += y_input * aceleration * get_physics_process_delta_time()
		motion.y = clamp(motion.y, -max_speed, max_speed)
		if global_position.y > 460:
			y_input = -1
		if global_position.y < 20:
			y_input = 1
	elif y_input == 0 and state == "follow":
		$AnimationPlayer.play("static")
		motion.y = lerp(motion.y, 0, friction)
	elif state == "static" and bullets > 0:
		$AnimationPlayer.play("bullet")
	elif state == "static" and bullets == 0:
		$AnimationPlayer.play("static")
	motion = move_and_slide(motion)
	if bullets == 3:
		$NumberOfBullet/Bullet.show()
		$NumberOfBullet/Bullet2.show()
		$NumberOfBullet/Bullet3.show()
		inmunity = true
	elif bullets == 2:
		$NumberOfBullet/Bullet.show()
		$NumberOfBullet/Bullet2.show()
		$NumberOfBullet/Bullet3.hide()
		inmunity = true
	elif bullets == 1:
		$NumberOfBullet/Bullet.show()
		$NumberOfBullet/Bullet2.hide()
		$NumberOfBullet/Bullet3.hide()
		inmunity = true
	elif bullets == 0:
		$NumberOfBullet/Bullet.hide()
		$NumberOfBullet/Bullet2.hide()
		$NumberOfBullet/Bullet3.hide()

func _on_BulletTimer_timeout():
	var bullet = Bullet.instance()
	state = "static"
	if bullets == 3:
		bullets = 2
		$BulletTimer.start()
		owner.add_child(bullet)
		bullet.global_position.y = global_position.y
		bullet.global_position.x = global_position.x - 20
		inmunity = true
	elif bullets == 2:
		bullets = 1
		$BulletTimer.start()
		owner.add_child(bullet)
		bullet.global_position.y = global_position.y
		bullet.global_position.x = global_position.x - 20
		inmunity = true
	elif bullets == 1:
		bullets = 0
		$BulletTimer.start()
		owner.add_child(bullet)
		bullet.global_position.y = global_position.y
		bullet.global_position.x = global_position.x - 20
		inmunity = true
	elif bullets == 0:
		$Shield.hide()
		$Recharge.start()
		inmunity = true
	yield(get_tree().create_timer(.5),"timeout")
	state = "follow"

func _on_Recharge_timeout():
	$Shield.show()
	bullets = 3
	$BulletTimer.start()
	inmunity = true

# warning-ignore:unused_argument
func _on_Area2D_area_entered(area):
	if life > 1 and inmunity == false:
		life -=1
		$Sprite/Hit.show()
	elif life <= 1 and inmunity == false:
		$Sprite/Arms.hide()
		$Sprite/Body.hide()
		$Sprite/Arms.hide()
		$Sprite/Hit.show()
		$BulletTimer.stop()
		$Recharge.stop()
		bullets = 0
	inmunity = true
	yield(get_tree().create_timer(.5),"timeout")
	if life <= 1 and inmunity == false:
		queue_free()
	else:
		$Sprite/Hit.hide()
		inmunity = false
