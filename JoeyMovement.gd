extends CharacterBody2D
var is_punch = false
var is_gun = false
var speed = 150

func _process(delta):
	if Input.is_action_pressed("change_weapon"):
		is_gun = !is_gun
	
	if (is_gun):
		var gun_position = Vector2(1, 1)
		var angle_to_mouse = gun_position.angle_to_point(get_local_mouse_position())
		var usable_angle = rad_to_deg(angle_to_mouse)
		var final_vector = Vector2.from_angle(angle_to_mouse) * 100
		$Crosshair.scale = Vector2(0.3,0.3)
		$Crosshair.position = final_vector
	else:
		var gun_position = Vector2(1, 1)
		var angle_to_mouse = gun_position.angle_to_point(get_local_mouse_position())
		var usable_angle = rad_to_deg(angle_to_mouse)
		var final_vector = Vector2.from_angle(angle_to_mouse) * 30
		$Crosshair.scale = Vector2(1,1)
		$Crosshair.position = final_vector
	
	
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
	
