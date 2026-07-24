extends CharacterBody2D

@onready var player = get_node("/root/Mainscene/Joey")
@onready var hurt_box = get_node("/root/Mainscene/Joey/Hurtbox")

func _physics_process(delta):
	if self in hurt_box.get_overlapping_bodies():
		velocity = Vector2.ZERO
	else:
		var direction = global_position.direction_to(player.global_position)
		velocity = direction * 85

	move_and_slide()
