extends TextureButton


func _ready() -> void:
	pressed.connect(playgame, 4 )# 4 is bit of ConnectFlags.CONNECT_ONE_SHOT
	#you can use .bind() to bind a value to the function

func playgame():
	#get_tree().change_scene_to_packed(main_scene)
	get_tree().change_scene_to_file("res://scenes/mainscene.tscn")
