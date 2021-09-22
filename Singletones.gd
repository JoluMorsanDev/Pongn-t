extends Node

var firsttimeplaying = true
var levelsunlocked = 0
var selectorlevelsunlocked = 0
var firsttimeplayingfile = "user://firsttime.save"
var levelsunlockedfile = "user://levels.save"
var selectorlevelsunlockedfile = "user://choose.save"
var hitsound = load("res://Assets/Sound&Music/hit.wav")
var hitnode = AudioStreamPlayer.new()
var bouncesound = load("res://Assets/Sound&Music/Jump.wav")
var bouncenode = AudioStreamPlayer.new()


# Called when the node enters the scene tree for the first time.
func _ready():
	load_first_time()
	load_levels_unlocked()
	hitnode.stream = hitsound
	bouncenode.stream = bouncesound

func play_bounce():
	bouncenode.play()

func play_hit():
	hitnode.play()

func save_first_time():
	var file = File.new()
	file.open(firsttimeplayingfile, File.WRITE)
	file.store_var(firsttimeplaying)
	file.close()

func save_levels_unlocked():
	var file = File.new()
	file.open(levelsunlockedfile, File.WRITE)
	file.store_var(levelsunlocked)
	file.close()
	var file2 = File.new()
	file2.open(selectorlevelsunlockedfile, File.WRITE)
	file2.store_var(selectorlevelsunlocked)
	file2.close()

func load_first_time():
	var file = File.new()
	if file.file_exists(firsttimeplayingfile):
		file.open(firsttimeplayingfile, File.READ)
		firsttimeplaying = file.get_var()
		file.close()
	else:
		firsttimeplaying = true

func load_levels_unlocked():
	var file = File.new()
	if file.file_exists(levelsunlockedfile):
		file.open(levelsunlockedfile, File.READ)
		levelsunlocked = file.get_var()
		file.close()
	else:
		levelsunlocked = 0
	var file2 = File.new()
	if file2.file_exists(selectorlevelsunlockedfile):
		file2.open(selectorlevelsunlockedfile, File.READ)
		selectorlevelsunlocked = file2.get_var()
		file2.close()
	else:
		selectorlevelsunlocked = 0

func earse_data():
	var file = File.new()
	file.open(levelsunlockedfile, File.WRITE)
	file.store_var(0)
	file.close()
	var file2 = File.new()
	file2.open(firsttimeplayingfile, File.WRITE)
	file2.store_var(true)
	file2.close()
	var file3 = File.new()
	file3.open(selectorlevelsunlockedfile, File.WRITE)
	file3.store_var(0)
	file3.close()
	get_tree().quit()
