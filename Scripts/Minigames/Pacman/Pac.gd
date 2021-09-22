extends KinematicBody2D

export (PackedScene) var Ghost 
export (PackedScene) var CherryBomb
export (PackedScene) var Peacherang
var life = 4
export var shield = false
var inmunity = false

func ghost_summon():
	var ghost = Ghost.instance()
	owner.add_child(ghost)
	ghost.global_position = Vector2(720, global_position.y)
	ghost.speed = rand_range(325,375)

func cherry_summon():
	var cherry = CherryBomb.instance()
	owner.add_child(cherry)
	cherry.global_position.y = global_position.y

func peach_summon():
	var peach = Peacherang.instance()
	owner.add_child(peach)
	peach.global_position.y = global_position.y

func _on_MoveAttack_animation_finished(anim_name):
	if anim_name == "Simplemove":
		$MoveAttack.playback_speed = 1
		if rand_range(0,1) > .2:
			match int(rand_range(0,2)):
				0:
					$MoveAttack.play("SimpleMove")
				1:
					$MoveAttack.play("MoveGhost")
				2:
					$MoveAttack.play("MoveFruits")
					$MoveAttack.playback_speed = .75
		else:
			$MoveAttack.play("SimpleMove")
	else:
		match int(rand_range(0,4)):
			0:
				$MoveAttack.play("SimpleMove")
			1:
				$MoveAttack.play("MoveGhost")
			2:
				$MoveAttack.play("MoveFruits")
				$MoveAttack.playback_speed = .75
			3:
				$MoveAttack.play("MoveGhost")
			4:
				$MoveAttack.play("MoveFruits")


func _on_Timer_timeout():
	$InmunityAnim.stop()
	$Body.visible = true
	inmunity = false


# warning-ignore:unused_argument
func _on_HitArea_area_entered(area):
	if inmunity == false:
		inmunity = true
		life -= 1
		$IT.start()
		$InmunityAnim.play("Nueva Animación")
		if life <= 0:
			queue_free()
