extends Node2D

var life = 3

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# warning-ignore:unused_argument
func _process(delta):
	if Input.is_action_pressed("ui_select"):
# warning-ignore:return_value_discarded
		get_tree().reload_current_scene()
	if life >= 0:
		$LifeLabel.text = "Life: " + str(life)

func _on_Ball_hit():
	if life > 0:
		life -= 1
