extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$Pause.hide()

# warning-ignore:unused_argument
func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		if get_tree().paused == false:
			_on_PauseButton_pressed()
		else:
			_on_Continue_pressed()


func _on_PauseButton_pressed():
	$Pause.show()
	get_tree().paused = true


func _on_Continue_pressed():
	$Pause.hide()
	get_tree().paused = false


func _on_Home_pressed():
	get_tree().paused = false
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Scenes/MainMenu.tscn")
