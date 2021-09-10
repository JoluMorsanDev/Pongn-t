extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().paused = false
	match Singletones.levelsunlocked:
		0:
			$PlayButton.text = "> Play Night 1"
		1:
			$PlayButton.text = "> Play Night 2"
		2:
			$PlayButton.text = "> Play Night 3"
		3:
			$PlayButton.text = "> Play Night 4"
		4:
			$PlayButton.text = "> Play Night 1"

func _on_ExitButton_pressed():
	get_tree().quit()


func _on_SettingsButton_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Scenes/Settings.tscn")


func _on_LevelsButton_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Scenes/ChoosingLvl.tscn")

func _on_PlayButton_pressed():
	match Singletones.levelsunlocked:
		0:
			# warning-ignore:return_value_discarded
			get_tree().change_scene("res://Scenes/Levels/SpaceInvaders.tscn")
		1:
			# warning-ignore:return_value_discarded
			get_tree().change_scene("res://Scenes/Levels/GunFight.tscn")
		2:
			# warning-ignore:return_value_discarded
			get_tree().change_scene("res://Scenes/Levels/DonkeyKong.tscn")
		3:
			# warning-ignore:return_value_discarded
			get_tree().change_scene("res://Scenes/Levels/SirTartarus.tscn")
		4:
			# warning-ignore:return_value_discarded
			get_tree().change_scene("res://Scenes/Levels/SpaceInvaders.tscn")

func _on_CreditsButton_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Scenes/Credits.tscn")
