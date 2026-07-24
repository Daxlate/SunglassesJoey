extends CharacterBody2D

@onready var player = get_node("/root/Mainscene/Joey")
@onready var hurt_box = get_node("/root/Mainscene/Joey/Hurtbox")
var Punch_cooldown = 0.0
var in_punch_range = false

func _physics_process(delta):
	if self in hurt_box.get_overlapping_bodies():
		velocity = Vector2.ZERO
		
		
		if !in_punch_range:
			in_punch_range = true
			Punch_cooldown = 0.8
			
		Punch_cooldown -= delta
		
		if Punch_cooldown <= 0:
			print("PUNCHED!")
			Punch_cooldown = 1.0
			
		
	else:
		in_punch_range = false
		Punch_cooldown = 0.0
		var direction = global_position.direction_to(player.global_position)
		velocity = direction * 70

	move_and_slide()
