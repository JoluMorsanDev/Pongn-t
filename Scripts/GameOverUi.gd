extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Retry_pressed():
	get_tree().paused = false
# warning-ignore:return_value_discarded
	get_tree().reload_current_scene()


func _on_Home_pressed():
	get_tree().paused = false
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Scenes/MainMenu.tscn")


func _on_Exit_pressed():
	get_tree().paused = false
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Scenes/MainMenu.tscn")


func _on_Next_pressed():
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
