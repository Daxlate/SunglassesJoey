extends goon

var wait_time := 0.0

func _ready() -> void:
	speed = 55
func _physics_process(delta):
	var direction = global_position.direction_to(player.global_position)
	
	if self in limit.get_overlapping_bodies() and !knocked_back:
		free_to_move = false
		wait_time = 2.0
		velocity = Vector2.ZERO
	else:
		if !free_to_move:
			wait_time  -= delta
			if wait_time <= 0:
				free_to_move = true
			
	if !knocked_back:
		if free_to_move:
			velocity = direction * 55
	else:
		if gun_knockback:
			$knockedtime.start()
			velocity = direction * player.gun_knockback * knockback_resistance
			gun_knockback = false
	
		if punch_knockback:
			$knockedtime.start()
			velocity = direction * player.punch_knockback * knockback_resistance
			punch_knockback = false
	move_and_slide()

func _on_timer_timeout() -> void:
	if self in limit.get_overlapping_bodies():
		shoot()
func _on_knockedtime_timeout() -> void:
	knocked_back = false
