extends Node2D

	
func spawnmob():
	var basic_goon_scene = preload("res://scenes/basic_goon.tscn")
	var basic_goon = basic_goon_scene.instantiate()
	%PathFollow2D.progress_ratio = randf()
	basic_goon.global_position = %PathFollow2D.global_position
	add_child(basic_goon)
	
func spawnmobranged():
	var ranged_goon_scene = preload("res://scenes/ranged_goon.tscn")
	var ranged_goon = ranged_goon_scene.instantiate()
	%PathFollow2D.progress_ratio = randf()
	ranged_goon.global_position = %PathFollow2D.global_position
	add_child(ranged_goon)


func _on_timer_timeout() -> void:
	spawnmob()


func _on_range_timeout() -> void:
	spawnmobranged()
