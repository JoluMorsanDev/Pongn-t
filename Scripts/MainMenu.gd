extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().paused = false
	if Singletones.levelsunlocked == 0:
		$PlayButton.text = "> Play Night 1"
	elif Singletones.levelsunlocked == 1:
		$PlayButton.text = "> Play Night 2"
	elif Singletones.levelsunlocked == 2:
		$PlayButton.text = "> Play Night 3"

func _on_ExitButton_pressed():
	get_tree().quit()


func _on_SettingsButton_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Scenes/Settings.tscn")


func _on_LevelsButton_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Scenes/ChoosingLvl.tscn")

func _on_PlayButton_pressed():
	if Singletones.levelsunlocked == 0:
# warning-ignore:return_value_discarded
		get_tree().change_scene("res://Scenes/Levels/SpaceInvaders.tscn")
	elif Singletones.levelsunlocked == 1:
# warning-ignore:return_value_discarded
		get_tree().change_scene("res://Scenes/Levels/GunFight.tscn")
	elif Singletones.levelsunlocked == 2:
# warning-ignore:return_value_discarded
		get_tree().change_scene("res://Scenes/Levels/DonkeyKong.tscn")

func _on_CreditsButton_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Scenes/Credits.tscn")
