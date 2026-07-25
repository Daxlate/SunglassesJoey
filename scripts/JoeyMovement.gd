extends CharacterBody2D
var is_punch = false
var is_gun = false
var speed = 150
var cooldown = false
var upgrades = [false]
@onready var Crosshair = $Crosshair/Marker2D

func _process(delta):
	
	var gun_position = Vector2(1, 1)
	var angle_to_mouse = gun_position.angle_to_point(get_local_mouse_position())
	var usable_angle = rad_to_deg(angle_to_mouse)
	var final_vector = Vector2.from_angle(angle_to_mouse) * 40
	$Crosshair.scale = Vector2(0.3,0.3)
	$Crosshair.position = final_vector
	if (Input.is_action_just_pressed("shoot") && cooldown == false):
		cooldown = true
		shoot(usable_angle)
		$Timer.start()
	
func shoot(angle_radians):
	const JOEYBULLET = preload("res://scenes/joey_bullet.tscn")
	var new_bullet = JOEYBULLET.instantiate()
	new_bullet.global_position = Crosshair.global_position
	new_bullet.global_rotation = deg_to_rad(angle_radians)
	get_tree().current_scene.add_child(new_bullet)

	
func _physics_process(delta):
	var direction = Input.get_vector("MoveLeft","MoveRight","MoveUp","MoveDown")
	velocity = direction * speed
	move_and_slide()
	if is_punch:
		Punchanim()
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
	


func _on_timer_timeout() -> void:
	cooldown = false
