extends Node2D

@onready var collectbox = get_node("/root/Mainscene/Joey/Collectzone")
@onready var The_timer = get_node("/root/Mainscene/Thetimer")
@onready var player = get_node("/root/Mainscene/Joey")
var inradius : bool
var get_atracted : bool
var Speed = 180
var timeadded = 3
@onready var original_position: Vector2 = global_position

@export var attraction_speed := 90.0
@export var max_attraction_speed := 700.0
@export var acceleration := 1500.0

var velocity := Vector2.ZERO
var sincalc = 1

func _physics_process(delta):
	var direction = global_position.direction_to(player.global_position)
	if inradius and !get_atracted:
		velocity = -direction * Speed
		Speed = move_toward(Speed, 0.0, 400.0 * delta)
	elif get_atracted:
		velocity = velocity.move_toward( direction * max_attraction_speed, acceleration * delta)
	else:
		$AnimatedSprite2D.move_local_y(sin(sincalc) * 0.2)
		$AnimatedSprite2D.move_local_x(cos(sincalc)*sin(sincalc)*0.1)
		$Timeorbshadow.move_local_x(cos(sincalc)*sin(sincalc)*0.1)
		sincalc += 0.05
	position += velocity * delta
	


func _on_area_entered(area) -> void:
	$Timer.start()
	if area != collectbox:
		inradius = true
	else:
			if The_timer.has_method("change_time") && collectbox:
				The_timer.change_time(timeadded)
				queue_free()


func _on_timer_timeout() -> void:
	get_atracted = true
