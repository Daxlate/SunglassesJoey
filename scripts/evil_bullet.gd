extends Area2D

var traveled_distance = 0

func _physics_process(delta: float) -> void:
	var Speed = 1000
	const RANGE = 1300
	
	var direction = Vector2.RIGHT.rotated(rotation) 
	position += direction * 500 * delta
	
	traveled_distance += Speed * delta
	if traveled_distance > RANGE:
		queue_free()


func _on_body_entered(body):
	if body.has_method("take_damage"):
		body.take_damage(-5)
	queue_free()
