extends CharacterBody2D
var is_punch = false
var is_gun = false
var speed = 150
var gun_knockback = -20
var punch_knockback = -150
var cooldown = false
var upgrades = [false, false, false, false, false, false, false, false]
var gun_attack = 5
var punch_attack = 2.5
var test = 0
var crit_chance: float = 0.0
var punch_cd = 1
@onready var pickup_size = $pickupradius/CollisionShape2D
@onready var Crosshair = $Crosshair/Marker2D
@onready var cooltime = $Timer.wait_time
@onready var The_timer = get_node_or_null("/root/Mainscene/Thetimer")

func _process(_delta):
	
	$Label.text = str(pickup_size)
	var gun_position = Vector2(1, 1)
	var angle_to_mouse = gun_position.angle_to_point(get_local_mouse_position())
	var usable_angle = rad_to_deg(angle_to_mouse)
	var final_vector = Vector2.from_angle(angle_to_mouse) * 40
	$Crosshair.scale = Vector2(0.3,0.3)
	$Crosshair.position = final_vector
	$Crosshair/CollisionShape2D.global_rotation = angle_to_mouse
	if (Input.is_action_pressed("shoot") && cooldown == false && get_tree().paused == false):
		cooldown = true
		shoot(usable_angle)
		if upgrades[5] == true:
			shoot(usable_angle - 30)
			shoot(usable_angle + 30)
		$Timer.start(cooltime)

func shoot(angle_radians):
	const JOEYBULLET = preload("res://scenes/joey_bullet.tscn")
	var new_bullet = JOEYBULLET.instantiate()
	new_bullet.global_position = Crosshair.global_position
	new_bullet.global_rotation = deg_to_rad(angle_radians)
	get_tree().current_scene.add_child(new_bullet)

	
func _physics_process(_delta):
	var direction = Input.get_vector("MoveLeft","MoveRight","MoveUp","MoveDown")
	velocity = direction * speed
	move_and_slide()
	if is_punch:
		if $AnimatedSprite2D.animation != "punch":
			$AnimatedSprite2D.play("punch")
			await get_tree().create_timer(punch_cd).timeout
			is_punch = false
	else:
		if velocity.length() > 0.0:
			Walkanim()
		else:
			Idleanim()
	
func Idleanim():
	$AnimatedSprite2D.play("default")
func Walkanim():
	$AnimatedSprite2D.play("walk")
func Punchanim():
	$AnimatedSprite2D.play("punch")
	
func take_damage(enemy_dmg):
	if(The_timer != null):
		if The_timer.has_method("change_time"):
				The_timer.change_time(enemy_dmg)
		print("ouch")
		damage_indicator(enemy_dmg)

func _on_timer_timeout() -> void:
	cooldown = false

func damage_indicator(damage: int):
	const DAMAGELABEL = preload("res://scenes/DamageAnnotation.tscn")
	var new_label = DAMAGELABEL.instantiate()
	new_label.global_position = global_position
	new_label.text = str(damage)
	get_tree().current_scene.add_child(new_label)
