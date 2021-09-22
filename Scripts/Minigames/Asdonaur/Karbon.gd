extends Node2D

export (PackedScene) var Fire

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func firegen():
	var fire = Fire.instance()
	add_child(fire)
	fire.show_behind_parent = true
	fire.global_position = Vector2(global_position.x, global_position.y + rand_range(-10,10))
	var fire2 = Fire.instance()
	add_child(fire2)
	fire2.show_behind_parent = true
	fire2.global_position = Vector2(global_position.x, global_position.y + rand_range(-10,10))
	var fire3 = Fire.instance()
	add_child(fire3)
	fire3.show_behind_parent = true
	fire3.global_position = Vector2(global_position.x, global_position.y + rand_range(-10,10))
