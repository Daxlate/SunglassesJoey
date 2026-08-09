extends Node2D

var Spawn_cap := 20
var Spawn_amount := 0
var Spawn_multiplier := 1.5
var Timer_multiplier := 0.95
var wave_number := 1
var Current_preset
var wave_difficulty = 1

@export var Wavetimer: Timer
@export var testlabel: Label

func spawner():
	
	match(Current_preset):
	
		1:preset_melee()
		2:preset_mixed()
		3:preset_mixed()
		
	if Current_preset == null:
		Current_preset = 1
	
	
	
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



func _on_wave_spawn_timer_timeout() -> void:
	
	if wave_number > 10:
		wave_number = 1
		wave_difficulty = 1
		
	if Spawn_amount == Spawn_cap:
		match (wave_number):
			3: wave_difficulty = 2
			6: wave_difficulty = 3
			10: wave_difficulty = 3
		Spawn_amount = 0
		Spawn_cap = Spawn_cap * Spawn_multiplier
		Wavetimer.wait_time = Wavetimer.wait_time * Timer_multiplier
		Current_preset = preset_choose()
		wave_number += 1
		
	testlabel.text = str(Spawn_cap) + " " + str(Wavetimer.wait_time) + " " + str(wave_number) + " " + str(Current_preset) + " " + str(wave_difficulty)
	spawner()
	Spawn_amount += 1
	
	
func testpreset():
	var rand_range = randi_range(1,10)
	if rand_range < 8:
		spawnmobmelee()
	else:
		spawnmobranged()

func preset_melee():
	
	match(wave_difficulty):
		1:
			spawnmobmelee()
		2:
			spawnmobmelee()
		3:
			spawnmobmelee()


func preset_mixed():
	match(wave_difficulty):
		1:
			var rand_range = randi_range(1,10)
			if rand_range < 8:
				spawnmobmelee()
			else:
				spawnmobranged()
		2:
			var rand_range = randi_range(1,10)
			if rand_range < 8:
				spawnmobmelee()
			else:
				spawnmobranged()
		3:
			var rand_range = randi_range(1,10)
			if rand_range < 8:
				spawnmobmelee()
			else:
				spawnmobranged()
				
func preset_rangedmixed():
	match(wave_difficulty):
		1:
			var rand_range = randi_range(1,10)
			if rand_range > 8:
				spawnmobmelee()
			else:
				spawnmobranged()
		2:
			var rand_range = randi_range(1,10)
			if rand_range > 8:
				spawnmobmelee()
			else:
				spawnmobranged()
		3:
			var rand_range = randi_range(1,10)
			if rand_range > 8:
				spawnmobmelee()
			else:
				spawnmobranged()

	
func preset_choose():
	var rand_range = randi_range(1,3)
	return rand_range
