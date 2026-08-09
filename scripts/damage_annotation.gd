extends Label
var yspeed: float = -5
var num: float = 150
var blue = 1.0
var actualC: Color = Color(1.0, 1.0, blue, 1.0)
var showntext: String = "ERROR"

func _physics_process(delta: float) -> void:
	position += Vector2(0, yspeed)
	yspeed = yspeed*1.05
	actualC = Color(1.0, 1.0, blue, (num/100))
	self_modulate = actualC
	num += -5
	#text = showntext
	if num <= 0:
		queue_free()
