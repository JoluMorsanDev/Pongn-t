extends RigidBody2D

var movement = "down"
var speed = 50
var dir = Vector2()

func _ready():
	down()

func _process(delta):
	global_position.x +=  dir.x * speed * delta
	global_position.y +=  dir.y * speed * delta

func down():
	movement = "down"
	dir.y = 1
	dir.x = 0
	$TurnTimer.start()

func up():
	movement = "up"
	dir.y = -1
	dir.x = 0
	$TurnTimer.start()

func leftup():
	movement = "leftup"
	dir.x = -1
	dir.y = 0
	$TurnTimer.start()

func leftdown():
	movement = "leftdown"
	dir.x = -1
	dir.y = 0
	$TurnTimer.start()

func wait():
	dir.x = 0
	dir.y = 0
	$WaitTimer.start()

func _on_TurnTimer_timeout():
	wait()

func _on_WaitTimer_timeout():
	if movement == "up":
		$TurnTimer.wait_time = 0.5
		leftup()
	elif movement == "down":
		$TurnTimer.wait_time = 0.5
		leftdown()
	elif movement == "leftup":
		$TurnTimer.wait_time = 1
		down()
	elif movement == "leftdown":
		$TurnTimer.wait_time = 1
		up()


# warning-ignore:unused_argument
func _on_Area2D2_body_entered(body):
	queue_free()
