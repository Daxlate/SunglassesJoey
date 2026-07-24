extends Area2D
var enemy_in_area
var cooldown = false
var joey = get_parent()

func _process(delta):
	var enemies_in_range = get_overlapping_bodies()
	if enemies_in_range.size() > 0:
		$Fuckingcirlce.modulate = Color(255.014, 0.0, 0.0, 0.196)
		if (Input.is_action_pressed("shoot") && cooldown == false):
			cooldown = true
			$Timer.start()
			if joey.has_method("take_damage"):
				joey.take_damage()
		if cooldown:
			$Fuckingcirlce.modulate = Color(255.014, 255.014, 0.0, 0.196)
	else:
		$Fuckingcirlce.modulate = Color(255.014, 255.014, 255.014, 0.196)
		if cooldown:
					$Fuckingcirlce.modulate = Color(0.132, 0.132, 0.132, 0.196)



func _on_timer_timeout() -> void:
	cooldown = false
