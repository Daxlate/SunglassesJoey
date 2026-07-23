extends Button



func _ready() -> void:
	pressed.connect(exitgame)

func exitgame():
	get_tree().quit()
