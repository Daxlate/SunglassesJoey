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
			Punch_cooldown = 0.5
		
		Punch_cooldown -= delta
		
		if Punch_cooldown <= 0:
			print("PUNCHED!")
			punch_anim()
			Punch_cooldown = 0.7
			
		
	else:
		walk_anim()
		in_punch_range = false
		Punch_cooldown = 0.0
		var direction = global_position.direction_to(player.global_position)
		velocity = direction * 70

	move_and_slide()

func punch_anim():
	$AnimatedSprite2D.play("Punch")
func walk_anim():
	$AnimatedSprite2D.play("default")
