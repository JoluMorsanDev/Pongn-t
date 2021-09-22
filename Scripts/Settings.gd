extends Node2D

var music = true
var sfx = true

# Called when the node enters the scene tree for the first time.
func _ready():
	if AudioServer.is_bus_mute(1):
		music = false
		$Music/Label.text = "no"
	else:
		music = true
		$Music/Label.text = "yes"
	if AudioServer.is_bus_mute(2):
		sfx = false
		$Sfx/Label.text = "no"
	else:
		sfx = true
		$Sfx/Label.text = "yes"

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Back_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Scenes/MainMenu.tscn")

func _on_More_pressed():
	if music == true:
		music = false
	else:
		music = true
	change_music()

func _on_Down_pressed():
	if music == true:
		music = false
	else:
		music = true
	change_music()

func _on_Up_pressed():
	if sfx == true:
		sfx = false
	else:
		sfx = true
	change_sfx()

func _on_Less_pressed():
	if music == true:
		music = false
	else:
		music = true
	change_sfx()

func change_music():
	if music == true:
		AudioServer.set_bus_mute(1, false)
		$Music/Label.text = "yes"
	else:
		AudioServer.set_bus_mute(1, true)
		$Music/Label.text = "no"

func change_sfx():
	if sfx == true:
		AudioServer.set_bus_mute(2, false)
		$Sfx/Label.text = "yes"
	else:
		AudioServer.set_bus_mute(2, true)
		$Sfx/Label.text = "no"


func _on_DeleteData_pressed():
	Singletones.earse_data()
