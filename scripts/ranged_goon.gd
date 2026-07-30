extends CharacterBody2D

@onready var player = get_node("/root/Mainscene/Joey")
@onready var limit = get_node("/root/Mainscene/Joey/RangedLimit")
@onready var The_timer = get_node("/root/Mainscene/Thetimer")

var free_to_move := true
var wait_time := 0.0
var health = 10.0

func _physics_process(delta):
	if self in limit.get_overlapping_bodies():
		free_to_move = false
		wait_time = 2.0
		velocity = Vector2.ZERO
	else:
		if !free_to_move:
			wait_time  -= delta
			if wait_time <= 0:
				free_to_move = true
			
	if free_to_move:
		var direction = global_position.direction_to(player.global_position)
		velocity = direction * 55

	move_and_slide()
	
func take_damage():
	$AnimationPlayer.play("Hurt")
	health -= player.attack
	if health <= 0:
		if The_timer.has_method("change_time"):
			The_timer.change_time(3)
		queue_free()

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
	
