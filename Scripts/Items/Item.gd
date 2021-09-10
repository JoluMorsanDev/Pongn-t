extends Area2D

var item_id = int()


# warning-ignore:unused_argument
func _on_Heart_area_entered(area):
	queue_free()
