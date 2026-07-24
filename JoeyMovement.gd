extends CharacterBody2D
var is_punch = false
func _process(delta):
	
	var gun_position = Vector2(1, 1)
	var angle_to_mouse = gun_position.angle_to_point(get_local_mouse_position())
	var usable_angle = rad_to_deg(angle_to_mouse)
	var final_vector = Vector2.from_angle(angle_to_mouse) * 50   
	$Crosshair.position = final_vector
	
	
	
func _physics_process(delta):
	var direction = Input.get_vector("MoveLeft","MoveRight","MoveUp","MoveDown")
	velocity = direction * 300
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
	
