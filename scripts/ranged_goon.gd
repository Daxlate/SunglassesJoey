extends Enemy

@onready var player = get_node("/root/Mainscene/Joey")
@onready var limit = get_node("/root/Mainscene/Joey/RangedLimit")
@onready var The_timer = get_node("/root/Mainscene/Thetimer")

var free_to_move := true
var wait_time := 0.0
var health = 10.0
var gun_knockback = false
var punch_knockback = false
var knocked_back = false
var knockback_resistance = 0.9

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
	
	
func take_gun_damage():
	$AnimationPlayer.play("Hurt")
	health -= player.gun_attack
	if health <= 0:
		if The_timer.has_method("change_time"):
			The_timer.change_time(3)
		queue_free()
		
func take_punch_damage():
	$AnimationPlayer.play("Hurt")
	health -= player.punch_attack
	if health <= 0:
		if The_timer.has_method("change_time"):
			The_timer.change_time(3)
		queue_free()
		
func Took_gun_Knockback():
	knocked_back = true
	gun_knockback = true

func Took_punch_Knockback():
	knocked_back = true
	punch_knockback = true

func shoot():
	const EVILBULLET = preload("res://scenes/evil_bullet.tscn")
	var new_bullet = EVILBULLET.instantiate()
	new_bullet.global_position = self.global_position
	var direction = global_position.direction_to(player.global_position)
	new_bullet.global_rotation = direction.angle()
	get_tree().current_scene.add_child(new_bullet)

func _on_timer_timeout() -> void:
	if self in limit.get_overlapping_bodies():
		shoot()
	

func _on_knockedtime_timeout() -> void:
	knocked_back = false
