extends KinematicBody2D

signal hit

# Called when the node enters the scene tree for the first time.
func _ready():
	$DamageAnim.play("Nueva Animación")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


# warning-ignore:unused_argument
func _on_Area2D_area_entered(area):
	print(area.owner.name)
	emit_signal("hit")
