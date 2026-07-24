extends TextureButton
var Upgrade = 1
var Title = ""
var Desc = ""
var lines = []

func _ready():
	var file = FileAccess.open("res://UpgradesText.txt", FileAccess.READ)
	while not file.eof_reached():
		lines.append(file.get_line())
	$UpgradeTitle1.text = read_specific_line(Upgrade)

func read_specific_line(line_index: int):
	var tit = "ERROR"
	if line_index < lines.size():
		tit = (lines[line_index])
	return tit
