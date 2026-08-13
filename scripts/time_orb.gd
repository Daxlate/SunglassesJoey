extends Node2D

@onready var collectbox = get_node("/root/Mainscene/Joey/Collectzone")
@onready var The_timer = get_node("/root/Mainscene/Thetimer")


func _on_area_entered(area) -> void:
	
	if area != collectbox:
		return
		
	if The_timer.has_method("change_time"):
		The_timer.change_time(3)
		queue_free()
