extends KinematicBody2D

var life = 5
var inmunity = true
export (PackedScene) var Bullet

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


# warning-ignore:unused_argument
func _on_LifeArea_body_entered(area):
	Singletones.play_hit()
	if life > 1:
		if inmunity == true:
			life -= 1
	else:
		if inmunity == true:
			queue_free()
	if inmunity == true:
		inmunity = false
		$InmunityTimer.start()
		inmunityflash()


func _on_InmunityTimer_timeout():
	inmunity = true
	modulate.a = 1
	yield(get_tree().create_timer(.05),"timeout")
	modulate.a = 1

func inmunityflash():
	if inmunity == false:
		modulate.a = 1
		yield(get_tree().create_timer(.05),"timeout")
		inmunityflashnt()

func inmunityflashnt():
	if inmunity == false:
		modulate.a = 0
		yield(get_tree().create_timer(.05),"timeout")
		inmunityflash()


func _on_BulletTimer_timeout():
	var bullet = Bullet.instance()
	owner.owner.add_child(bullet)
	bullet.speed = 150
	bullet.global_position = $BulletPos.global_position
