extends CharacterBody2D

@onready var player = get_node("/root/Mainscene/Joey")
@onready var limit = get_node("/root/Mainscene/Joey/RangedLimit")
var free_to_move := true
var wait_time := 0.0

func _physics_process(delta):
	if self in limit.get_overlapping_bodies():
		free_to_move = false
		wait_time = 2.0
		velocity = Vector2.ZERO
	else:
		if !free_to_move:
			wait_time  =- delta
			if wait_time <= 0:
				free_to_move = true
			
	if free_to_move:
		var direction = global_position.direction_to(player.global_position)
		velocity = direction * 55

	move_and_slide()
