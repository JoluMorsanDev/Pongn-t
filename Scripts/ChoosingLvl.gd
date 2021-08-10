extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	if Singletones.levelsunlocked == 0:
# warning-ignore:return_value_discarded
		get_tree().change_scene("res://Scenes/Levels/SpaceInvaders.tscn")
	elif Singletones.levelsunlocked == 1:
# warning-ignore:return_value_discarded
		get_tree().change_scene("res://Scenes/Levels/GunFight.tscn")
	elif Singletones.levelsunlocked == 2:
# warning-ignore:return_value_discarded
		get_tree().change_scene("res://Scenes/Levels/DonkeyKong.tscn")

func _on_Back_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Scenes/MainMenu.tscn")

func _on_PlayButton_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Scenes/Levels/SpaceInvaders.tscn")

func _on_PlayButton2_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Scenes/Levels/GunFight.tscn")

func _on_PlayButton3_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Scenes/Levels/DonkeyKong.tscn")
