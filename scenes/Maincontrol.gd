extends Node2D

	
func spawnmob():
	var basic_goon_scene = preload("res://scenes/basic_goon.tscn")
	var basic_goon = basic_goon_scene.instantiate()
	%PathFollow2D.progress_ratio = randf()
	basic_goon.global_position = %PathFollow2D.global_position
	add_child(basic_goon)


	


func _on_timer_timeout() -> void:
	spawnmob()
