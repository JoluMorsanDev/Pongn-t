extends Node2D

onready var ball = owner.get_node("Balls").get_node("Ball")
var jumpman_state = "normal"
var jumpman_life = 3
var target

signal hit


# Called when the node enters the scene tree for the first time.
func _ready():
	yield(get_tree().create_timer(0.5),"timeout")
	if jumpman_state == "normal":
		if target - $Jumpman.global_position.y < 0:
			$Jumpman/Body/HammerHand/Up.show()
			$Jumpman/Body/HammerHand/Down.hide()
			$AnimationPlayer.play("up")
		elif target - $Jumpman.global_position.y > 0:
			$Jumpman/Body/HammerHand/Up.hide()
			$Jumpman/Body/HammerHand/Down.show()
			$AnimationPlayer.play("down")

# Called every frame. 'delta' is the elapsed time since the previous frame.
# warning-ignore:unused_argument
func _process(delta):
	target = ball.global_position.y
	if jumpman_life >= 0:
		$JMLifeText.text = "J. M. Life: " + str(jumpman_life)

func _on_Jumpman_hit():
	jumpman_state = "stuned"
	$Jumpman/Area2D/CollisionPolygon2D.set_deferred("disabled", true)
	$Jumpman/Body/Damage.show()
	$StunTimer.start()

func _on_StunTimer_timeout():
	if target > 240:
		$AnimationPlayer.play("down")
	else:
		$AnimationPlayer.play("up")
	jumpman_state = "normal"
	$Jumpman/Area2D/CollisionPolygon2D.set_deferred("disabled", false)
	$Jumpman/Body/Damage.hide()

# warning-ignore:unused_argument
func _on_Area2D_area_entered(area):
	if jumpman_state == "normal":
		if target - $Jumpman.global_position.y < 0:
			$Jumpman/Body/HammerHand/Up.show()
			$Jumpman/Body/HammerHand/Down.hide()
			$AnimationPlayer.play("up")
		elif target - $Jumpman.global_position.y > 0:
			$Jumpman/Body/HammerHand/Up.hide()
			$Jumpman/Body/HammerHand/Down.show()
			$AnimationPlayer.play("down")

# warning-ignore:unused_argument
func _on_Area2D2_area_entered(area):
	if jumpman_life > 1:
		jumpman_life -= 1
	else:
		queue_free()
	emit_signal("hit")
