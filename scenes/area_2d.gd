extends Area2D
@onready var Goon = get_parent()


func _process(delta: float) -> void:
	var Entered_body = get_overlapping_bodies()
	if Entered_body.size() > 0:
		print("overlapped")
		Goon.velocity = Goon.velocity * 0
	
