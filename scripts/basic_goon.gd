extends CharacterBody2D

@onready var player = get_node("/root/Mainscene/Joey")
@onready var hurt_box = get_node("/root/Mainscene/Joey/Hurtbox")
@onready var The_timer = get_node("/root/Mainscene/Thetimer")
var Punch_cooldown = 0.0
var in_punch_range = false
var health = 10.0

func _physics_process(delta):
	if self in hurt_box.get_overlapping_bodies():
		velocity = Vector2.ZERO
		
		if !in_punch_range:
			in_punch_range = true
			Punch_cooldown = 0.3
		
		Punch_cooldown -= delta
		
		if Punch_cooldown <= 0:
			print("PUNCHED!")
			if The_timer.has_method("change_time"):
				The_timer.change_time(-1)
			if player.has_method("take_damage"):
				player.take_damage()
			punch_anim()
			Punch_cooldown = 0.5
			
		
	else:
		walk_anim()
		in_punch_range = false
		Punch_cooldown = 0.0
		var direction = global_position.direction_to(player.global_position)
		velocity = direction * 70

	move_and_slide()

func take_damage():
	$AnimationPlayer.play("Hurt")
	health -= player.attack
	if health <= 0:
		if The_timer.has_method("change_time"):
			The_timer.change_time(3)
		queue_free()
		queue_free()
	
	


func punch_anim():
	$AnimatedSprite2D.play("Punch")
func walk_anim():
	$AnimatedSprite2D.play("default")
