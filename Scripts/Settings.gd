extends Node2D

var music = 100
var sfx = 100

# Called when the node enters the scene tree for the first time.
func _ready():
	if AudioServer.is_bus_mute(1):
		music = 0
	else:
		music = (AudioServer.get_bus_volume_db(1)+28)/.28
	if AudioServer.is_bus_mute(2):
		sfx = 0
	else:
		sfx = (AudioServer.get_bus_volume_db(2)+28)/.28
	$Music/Label.text = str(int(music))
	$Sfx/Label.text = str(int(sfx))

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Back_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Scenes/MainMenu.tscn")

func _on_More_pressed():
	if music < 99:
		music += 1
		change_music()

func _on_Down_pressed():
	if music > 1:
		music -= 1
		change_music()

func _on_Up_pressed():
	if sfx < 99:
		sfx += 1
		change_sfx()

func _on_Less_pressed():
	if sfx > 1:
		sfx -= 1
		change_sfx()

func change_music():
	if music > 0:
		AudioServer.set_bus_volume_db(1, ((.28*music)-28))
		AudioServer.set_bus_mute(1, false)
	else:
		AudioServer.set_bus_mute(1, true)
	$Music/Label.text = str(music)

func change_sfx():
	if sfx > 0:
		AudioServer.set_bus_volume_db(2, ((.28*music)-28))
		AudioServer.set_bus_mute(2, false)
	else:
		AudioServer.set_bus_mute(2, true)
	$Sfx/Label.text = str(sfx)


func _on_DeleteData_pressed():
	Singletones.earse_data()
	yield(get_tree().create_timer(0.1),"timeout")
	get_tree().quit()
