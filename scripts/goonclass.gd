extends Enemy
class_name goon
# getting important shit
@onready var player = get_node("/root/Mainscene/Joey")
@onready var hurt_box = get_node("/root/Mainscene/Joey/Hurtbox")
@onready var The_timer = get_node("/root/Mainscene/Thetimer")
@onready var limit = get_node("/root/Mainscene/Joey/RangedLimit")
@onready var static_direction = global_position.direction_to(player.global_position)
# stats
var default_punch_cooldown: float = 3.0
var knockback_resistance: float = 1.5
var Punch_cooldown: float = 0.0
var health: float = 10.0
var orbamount: float = 1
var speed: int = 70
var atk: float = 2
# misc bools
var in_punch_range: bool = false
var gun_knockback: bool = false
var punch_knockback: bool = false
var knocked_back: bool = false
var free_to_move := true


func walk(direction):
	walk_anim()
	in_punch_range = false
	Punch_cooldown = 0.0
	velocity = direction * speed

#attacks
func shoot(bullet_direction:Vector2 = global_position.direction_to(player.global_position)):
	const EVILBULLET = preload("res://scenes/evil_bullet.tscn")
	var new_bullet = EVILBULLET.instantiate()
	new_bullet.global_position = self.global_position
	#var direction = global_position.direction_to(player.global_position)
	new_bullet.global_rotation = bullet_direction.angle()
	get_tree().current_scene.add_child(new_bullet)
func punch():
	if player.has_method("take_damage"):
		player.take_damage(atk * -1)
		punch_anim()
		Punch_cooldown = default_punch_cooldown

#Animations
func punch_anim():
	if $AnimatedSprite2D:
		$AnimatedSprite2D.play("Punch")
func walk_anim():
	if $AnimatedSprite2D:
		$AnimatedSprite2D.play("default")

#dying
func death():
	if health <= 0:
		instansiate_orb(orbamount)
		queue_free()
func instansiate_orb(orbs:int = 1):
	for i in orbs:
		const TIME_ORB = preload("res://scenes/time_orb.tscn")
		var timeorb = TIME_ORB.instantiate()
		get_tree().current_scene.call_deferred("add_child", timeorb)
		timeorb.global_position = global_position + Vector2(randi_range(-15,15),randi_range(-15,15))

#taking damage
func take_gun_damage():
	if $AnimationPlayer:
		$AnimationPlayer.play("Hurt")
	if (randf() <= player.crit_chance):
		health -= player.gun_attack * 2
		damage_indicator(player.gun_attack * 2, true)
	else:
		health -= player.gun_attack
		damage_indicator(player.gun_attack)
	death()
func take_punch_damage():
	if $AnimationPlayer:
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
func damage_indicator(damage: int, crit=false):
	const DAMAGELABEL = preload("res://scenes/DamageAnnotation.tscn")
	var new_label = DAMAGELABEL.instantiate()
	new_label.global_position = global_position
	new_label.text = str(damage)
	if crit:
		new_label.blue = 0.0
		new_label.text = str(damage) + "!"
	get_tree().current_scene.add_child(new_label)
func _on_knockedtime_timeout() -> void:
	knocked_back = false
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
