extends Enemy

@onready var player = get_node("/root/Mainscene/Joey")
@onready var hurt_box = get_node("/root/Mainscene/Joey/Hurtbox")
@onready var The_timer = get_node("/root/Mainscene/Thetimer")
@onready var static_direction = global_position.direction_to(player.global_position)


var Punch_cooldown = 0.0
var in_punch_range = false
var health = 10.0
var gun_knockback = false
var punch_knockback = false

func _physics_process(delta):
	var direction = global_position.direction_to(player.global_position)
	
	if self in hurt_box.get_overlapping_bodies():
		velocity = Vector2.ZERO
		
		if !in_punch_range:
			in_punch_range = true
			Punch_cooldown = 0.3
		
		Punch_cooldown -= delta
		
		if Punch_cooldown <= 0:
			print("PUNCHED!")
			if player.has_method("take_damage"):
				player.take_damage(-2)
			punch_anim()
			Punch_cooldown = 0.5
			
	else:
		walk_anim()
		in_punch_range = false
		Punch_cooldown = 0.0
		velocity = direction * 70
		
	if gun_knockback:
		velocity = direction * player.gun_knockback
		gun_knockback = false
	
	if punch_knockback:
		velocity = direction * player.punch_knockback
		punch_knockback = false
	
	move_and_slide()


func take_gun_damage():
	$AnimationPlayer.play("Hurt")
	health -= player.gun_attack
	damage_indicator(player.gun_attack)
	if health <= 0:
		if The_timer.has_method("change_time"):
			The_timer.change_time(3)
		queue_free()

func take_punch_damage():
	$AnimationPlayer.play("Hurt")
	health -= player.punch_attack
	damage_indicator(player.punch_attack)
	if health <= 0:
		if The_timer.has_method("change_time"):
			The_timer.change_time(3)
		queue_free()

	
func Took_gun_Knockback():
	gun_knockback = true
	
func Took_punch_Knockback():
	punch_knockback = true

func punch_anim():
	$AnimatedSprite2D.play("Punch")
func walk_anim():
	$AnimatedSprite2D.play("default")
	
func damage_indicator(damage: int):
	const DAMAGELABEL = preload("res://scenes/DamageAnnotation.tscn")
	var new_label = DAMAGELABEL.instantiate()
	new_label.global_position = global_position
	new_label.text = str(damage)
	get_tree().current_scene.add_child(new_label)
