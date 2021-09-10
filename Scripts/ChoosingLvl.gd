extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	match Singletones.levelsunlocked:
		0:
			$Nights/PlayButton.show()
			$Nights/PlayButton2.hide()
			$Nights/PlayButton3.hide()
			$Nights/PlayButton4.hide()
			$Nights/PlayButton5.hide()
			$Nights/PlayButton6.hide()
			$Nights/PlayButton7.hide()
			$Nights/PlayButton8.hide()
			$Nights/PlayButton9.hide()
			$Nights/BossLevel.hide()
		1:
			$Nights/PlayButton.show()
			$Nights/PlayButton2.show()
			$Nights/PlayButton3.hide()
			$Nights/PlayButton4.hide()
			$Nights/PlayButton5.hide()
			$Nights/PlayButton6.hide()
			$Nights/PlayButton7.hide()
			$Nights/PlayButton8.hide()
			$Nights/PlayButton9.hide()
			$Nights/BossLevel.hide()
		2:
			$Nights/PlayButton.show()
			$Nights/PlayButton2.show()
			$Nights/PlayButton3.show()
			$Nights/PlayButton4.hide()
			$Nights/PlayButton5.hide()
			$Nights/PlayButton6.hide()
			$Nights/PlayButton7.hide()
			$Nights/PlayButton8.hide()
			$Nights/PlayButton9.hide()
			$Nights/BossLevel.hide()
		3:
			$Nights/PlayButton.show()
			$Nights/PlayButton2.show()
			$Nights/PlayButton3.show()
			$Nights/PlayButton4.show()
			$Nights/PlayButton5.hide()
			$Nights/PlayButton6.hide()
			$Nights/PlayButton7.hide()
			$Nights/PlayButton8.hide()
			$Nights/PlayButton9.hide()
			$Nights/BossLevel.hide()
		4:
			$Nights/PlayButton.show()
			$Nights/PlayButton2.show()
			$Nights/PlayButton3.show()
			$Nights/PlayButton4.show()
			$Nights/PlayButton5.hide()
			$Nights/PlayButton6.hide()
			$Nights/PlayButton7.hide()
			$Nights/PlayButton8.hide()
			$Nights/PlayButton9.hide()
			$Nights/BossLevel.hide()

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

func _on_PlayButton4_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Scenes/Levels/SirTartarus.tscn")
