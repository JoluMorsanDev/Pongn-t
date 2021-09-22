extends RigidBody2D

export var speed = 600

# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.wait_time = rand_range(.5,1.5)
	$Timer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Kaboom.global_rotation_degrees = 0
	global_position += speed * delta * -transform.x


func _on_Timer_timeout():
	$Move.stop()
	$Boom.play("Nueva Animación")
