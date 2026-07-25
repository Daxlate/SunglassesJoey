extends TextureButton
var Upgrade = 0
var Title = ""
var Desc = ""
var lines = []
const FILEPATH = "res://UpgradesText.txt"
const DESCRIPTIONPATH = "res://UpgradesDescriptions.txt"



func UpdateTitle():
		var file = FileAccess.open("res://UpgradesText.txt", FileAccess.READ)
		while not file.eof_reached():
			lines.append(file.get_line())
			$UpgradeTitle1.text = read_specific_line(Upgrade)

func read_specific_line(line_number: int) -> String:
	# Open the file in read mode
	var file = FileAccess.open(FILEPATH, FileAccess.READ)
	if not file:
		return "ERROR NOT FILE"
		
	# Read the whole file and split it into individual lines
	var all_text = file.get_as_text()
	var lines = all_text.split("\n")
	
	# Check if the requested line index exists (0-indexed)
	if line_number >= 0 and line_number < lines.size():
		return lines[line_number]
	else:
		return "Line number out of bounds."
