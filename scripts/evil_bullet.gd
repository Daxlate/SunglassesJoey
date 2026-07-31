extends Area2D

var traveled_distance = 0

func _physics_process(delta: float) -> void:
	var Speed = 1000
	var direction = Vector2.RIGHT.rotated(rotation)
	const RANGE = 3300
	if !get_tree().paused:
		self.collision_mask = 1
		position += direction * 500 * delta
		if traveled_distance > RANGE:
			queue_free()
		traveled_distance += Speed * delta
	else:
		position += direction * 1 * delta
		self.collision_mask = 100


func _on_body_entered(body):
	if body.has_method("take_damage"):
		body.take_damage(-5)
	queue_free()
