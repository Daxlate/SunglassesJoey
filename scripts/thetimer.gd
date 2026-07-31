extends Control
signal timer_finished
@export var main_menu: PackedScene
@export var label: Label
var time_left = 30.0
var auto_start:= true
var running: bool = false

func _ready():
	start()
func set_label(new_label: Label) -> void:
	label = new_label
func gotomenu():
	get_tree().change_scene_to_packed(main_menu)
func _process(delta):
	
	if not running:
		gotomenu()
	
	time_left -= delta
	
	if time_left <= 0.0:
		time_left = 0.0
		running = false
		timer_finished.emit()
	_update_label()

func start():
	running = true

func stop():
	running = false
	
func change_time(amount):
	time_left += amount
	label.text = str(time_left)
	
func _update_label() -> void:
	#if label:
		#var minutes := int(time_left) / 60
		#var seconds := int(time_left) % 60
		#label.text = "%02d:%02d" % [minutes, seconds]
	var minutes: float = time_left/60
	var seconds = int(time_left)%60
	#for i in range(int(minutes)):
		#print("A MINUTE")
	%ClockTexture.value = seconds

	if time_left < 10:
		%ClockTexture.modulate = Color(0.502, 0.0, 0.0, 1.0)
	else:
		%ClockTexture.modulate =  Color(1.0, 1.0, 1.0, 1.0)
