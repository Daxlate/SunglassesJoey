extends Area2D

var traveled_distance = 0

func _physics_process(delta: float) -> void:
	const SPEED = 1000
	const RANGE = 1300
	
	var direction = Vector2.RIGHT.rotated(rotation) 
	position += direction * 1000 * delta
	
	traveled_distance += SPEED * delta
	if traveled_distance > RANGE:
		queue_free()


func _on_body_entered(body: Node2D) -> void:
	queue_free()
	if body.has_method("take_damage"):
		body.take_damage()
