extends Node2D

var Spawn_cap := 20
var Spawn_amount := 0
var Spawn_multiplier := 1.5
var Timer_multiplier := 0.95
var Current_preset

@export var Wavetimer: Timer
@export var testlabel: Label

func spawner():
	
	if Current_preset == 1:
		testpreset()
		
	if Current_preset == null:
		preset_choose()
		Current_preset = preset_choose()
		print(Current_preset)
	
func spawnmobmelee():
	var basic_goon_scene = preload("res://scenes/goons/basic_goon.tscn")
	var basic_goon = basic_goon_scene.instantiate()
	%PathFollow2D.progress_ratio = randf()
	basic_goon.global_position = %PathFollow2D.global_position
	add_child(basic_goon)
	
func spawnmobranged():
	var ranged_goon_scene = preload("res://scenes/goons/ranged_goon.tscn")
	var ranged_goon = ranged_goon_scene.instantiate()
	%PathFollow2D.progress_ratio = randf()
	ranged_goon.global_position = %PathFollow2D.global_position
	add_child(ranged_goon)



func _on_timer_timeout() -> void:
	if Spawn_amount == Spawn_cap:
		Spawn_amount = 0
		Spawn_cap = Spawn_cap * Spawn_multiplier
		Wavetimer.wait_time = Wavetimer.wait_time * Timer_multiplier
		Current_preset = preset_choose()
		
	testlabel.text = str(Spawn_cap) + " " + str(Wavetimer.wait_time)
	spawner()
	Spawn_amount += 1
	
func testpreset():
	var rand_range = randi_range(1,10)
	if rand_range < 7:
		spawnmobmelee()
	else:
		spawnmobranged()
	
func preset_choose():
	var rand_range = randi_range(1,1)
	return rand_range
