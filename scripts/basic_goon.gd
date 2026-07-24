extends CharacterBody2D

@onready var player = get_node("/root/Mainscene/Joey")
	
	
func physics_process(delta):
	var direction = global_position.direction_to(player.global_position)
	var velocity = direction * 170
	move_and_slide()
	
