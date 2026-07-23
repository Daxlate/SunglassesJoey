extends Button

@export var saveCtrl: SaveControl
@export var play_button: Button

func _ready() -> void:
	pressed.connect(_loadsave)
	

func _loadsave():
	saveCtrl.loadgame() 
	play_button.playgame()
