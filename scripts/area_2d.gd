extends Area2D
var enemy_in_area
var cooldown = false
@onready var joey = get_parent()

func _process(_delta):
	
	var enemies_in_range = get_overlapping_bodies()
	if enemies_in_range.size() >= 0:
		$Fuckingcirlce.modulate = Color(255.014, 0.0, 0.0, 0.196)
		if (Input.is_action_pressed("punch") and cooldown == false):
			cooldown = true
			$Cooldownpunch.start()
			joey.is_punch = true
			
			for body in enemies_in_range:
				if body is Enemy:
					if body.has_method("take_punch_damage"):
						body.take_punch_damage()
					if body.has_method("Took_punch_Knockback"):
						body.Took_punch_Knockback()
	
		if cooldown:
			$Fuckingcirlce.modulate = Color(255.014, 255.014, 0.0, 0.196)
	else:
		$Fuckingcirlce.modulate = Color(255.014, 255.014, 255.014, 0.196)
		if cooldown:
					$Fuckingcirlce.modulate = Color(0.132, 0.132, 0.132, 0.196)



func _on_timer_timeout() -> void:
	print("shitat")
	cooldown = false
	joey.is_punch = false
