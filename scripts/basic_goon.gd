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
var knocked_back = false
var knockback_resistance = 1.5

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
			joey_dmg()
		
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


func knockback_whilepunch(direction):
	if gun_knockback:
		$knockedtime.start()
		gun_knockback = false
	
	if punch_knockback:
		$knockedtime.start()
		punch_knockback = false
			
	if  !punch_knockback:
		walk_anim()
		velocity = direction * player.punch_knockback * knockback_resistance
				
	if !gun_knockback:
		walk_anim()
		velocity = direction * player.punch_knockback * knockback_resistance


func knockback_fromfar(direction):
	if gun_knockback:
		$knockedtime.start()
		velocity = direction * player.gun_knockback * knockback_resistance
		gun_knockback = false
	
	if punch_knockback:
		$knockedtime.start()
		velocity = direction * player.punch_knockback * knockback_resistance
		punch_knockback = false

func joey_dmg():
	print("PUNCHED!")
	if player.has_method("take_damage"):
		player.take_damage(-2)
		punch_anim()
		Punch_cooldown = 0.5

func take_gun_damage():
	$AnimationPlayer.play("Hurt")
	if (randf() <= player.crit_chance):
		health -= player.gun_attack * 2
		damage_indicator(player.gun_attack * 2, true)
	else:
		health -= player.gun_attack
		damage_indicator(player.gun_attack)
	death()
		
	

func take_punch_damage():
	$AnimationPlayer.play("Hurt")
	health -= player.punch_attack
	damage_indicator(player.punch_attack)
	death()


	
	
func Took_gun_Knockback():
	knocked_back = true
	gun_knockback = true
	
func Took_punch_Knockback():
	knocked_back = true
	punch_knockback = true

func punch_anim():
	$AnimatedSprite2D.play("Punch")
func walk_anim():
	$AnimatedSprite2D.play("default")
	
func damage_indicator(damage: int, crit=false):
	const DAMAGELABEL = preload("res://scenes/DamageAnnotation.tscn")
	var new_label = DAMAGELABEL.instantiate()
	new_label.global_position = global_position
	new_label.text = str(damage)
	if crit:
		new_label.blue = 0.0
		new_label.text = str(damage) + "!"
	get_tree().current_scene.add_child(new_label)
	
func death():
	if health <= 0:
		instansiate_orb()
		queue_free()

func instansiate_orb():
	const TIME_ORB = preload("res://scenes/time_orb.tscn")
	var timeorb = TIME_ORB.instantiate()
	get_tree().current_scene.call_deferred("add_child", timeorb)
	timeorb.global_position = global_position

func _on_knockedtime_timeout() -> void:
	knocked_back = false
