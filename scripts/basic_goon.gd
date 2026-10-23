extends goon


func _ready() -> void:
	orbamount = 3

func _physics_process(delta):
	var direction = global_position.direction_to(player.global_position)
	
	if self in hurt_box.get_overlapping_bodies():
		velocity = Vector2.ZERO
		
		if !in_punch_range:
			in_punch_range = true
			Punch_cooldown = 0.3
		if knocked_back:
			knockback_whilepunch(direction)
		
		Punch_cooldown -= delta
		
		if Punch_cooldown <= 0:
			punch()
		
	else:
		
		if !knocked_back:
			walk(direction)
		else:
			knockback_fromfar(direction)
	
	move_and_slide()
func walk(direction):
	walk_anim()
	in_punch_range = false
	Punch_cooldown = 0.0
	velocity = direction * 70
