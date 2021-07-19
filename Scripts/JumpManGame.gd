extends Node2D

onready var ball = owner.get_node("Balls").get_node("Ball")
var jumpman_state = "normal"
var jumpman_life = 3

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
# warning-ignore:unused_argument
func _process(delta):
	var target = ball.global_position.y
	if jumpman_state == "normal":
		if target - $Jumpman.global_position.y < 0:
			$Hammer.show()
			$Hammer/CollisionPolygon2D.set_deferred("disabled", false)
			$Jumpman/Body/HammerHand/Up.show()
			$Hammer2.hide()
			$Hammer2/CollisionPolygon2D.set_deferred("disabled", true)
			$Jumpman/Body/HammerHand/Down.hide()
		elif target - $Jumpman.global_position.y > 0:
			$Hammer.hide()
			$Hammer/CollisionPolygon2D.set_deferred("disabled", true)
			$Jumpman/Body/HammerHand/Up.hide()
			$Hammer2.show()
			$Hammer2/CollisionPolygon2D.set_deferred("disabled", false)
			$Jumpman/Body/HammerHand/Down.show()


func _on_Jumpman_hit():
	jumpman_state = "stuned"
	$Jumpman/Area2D/CollisionPolygon2D.set_deferred("disabled", true)
	$Jumpman/Body/Damage.show()
	$StunTimer.start()

func _on_StunTimer_timeout():
	jumpman_state = "normal"
	$Jumpman/Area2D/CollisionPolygon2D.set_deferred("disabled", false)
	$Jumpman/Body/Damage.hide()
