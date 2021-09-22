extends Node2D

export (PackedScene) var Heart
export (PackedScene) var Speed
export (PackedScene) var Shield
export var Hearts = true
export var Speeder = true
export var Slower = true
export var Shields = true

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	if Hearts == true:
		$HeartTimer.start()
	if Speeder == true:
		$SpeedTimer.start()
	if Slower == true:
		$SlowTimer.start()
	if Shields == true:
		$ShieldTimer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_HeartTimer_timeout():
	if get_node_or_null("heart") == null:
		var heart = Heart.instance()
		add_child(heart)
		heart.item_id = 0
		heart.name = "heart"
		heart.global_position = Vector2(rand_range(40, 680), rand_range(40, 440))
		#$HeartTimer.wait_time = int(rand_range(3.5,4.5))
		$HeartTimer.start()
	else:
		#$HeartTimerSecondaryr.wait_time = int(rand_range(1.5,2.5))
		$HeartTimerSecondary.start()


func _on_SpeedTimer_timeout():
	if get_node_or_null("speed") == null:
		var speed = Speed.instance()
		add_child(speed)
		speed.item_id = 1
		speed.name = "speed"
		speed.global_position = Vector2(rand_range(40, 680), rand_range(40, 440))
		#$SpeedTimer.wait_time = int(rand_range(3.5,4.5))
		$SpeedTimer.start()
	else:
		#$SpeedTimerSecondaryr.wait_time = int(rand_range(1.5,2.5))
		$SpeedTimerSecondary.start()

func _on_SlowTimer_timeout():
	if get_node_or_null("slow") == null:
		var slow = Speed.instance()
		add_child(slow)
		slow.item_id = 2
		slow.name = "slow"
		slow.scale.y = -1
		slow.global_position = Vector2(rand_range(40, 680), rand_range(40, 440))
		#$SpeedTimer.wait_time = int(rand_range(3.5,4.5))
		$SlowTimer.start()
	else:
		#$SpeedTimerSecondaryr.wait_time = int(rand_range(1.5,2.5))
		$SlowTimerSecondary.start()

func _on_ShieldTimer_timeout():
	if get_node_or_null("shield") == null:
		var shield = Shield.instance()
		add_child(shield)
		shield.item_id = 3
		shield.name = "shield"
		shield.global_position = Vector2(rand_range(40, 680), rand_range(40, 440))
		#$SpeedTimer.wait_time = int(rand_range(3.5,4.5))
		$ShieldTimer.start()
	else:
		#$SpeedTimerSecondaryr.wait_time = int(rand_range(1.5,2.5))
		$ShieldTimerSecondary.start()
