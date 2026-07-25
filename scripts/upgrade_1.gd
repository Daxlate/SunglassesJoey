extends TextureButton
var Upgrade = 1
var Title = ""
var Desc = ""
var lines = []
var filepath
const DESCRIPTIONPATH = "res://UpgradesDescriptions.txt"


func Update():
	UpdateTitle()
	UpdateDesc()
	UpdateIcon()

func UpdateTitle():
		filepath = "res://UpgradesText.txt"
		var file = FileAccess.open("res://UpgradesText.txt", FileAccess.READ)
		while not file.eof_reached():
			lines.append(file.get_line())
			$UpgradeTitle.text = read_specific_line(Upgrade)

func read_specific_line(line_number: int) -> String:
	# Open the file in read mode
	var file = FileAccess.open(filepath, FileAccess.READ)
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

func UpdateDesc():
		filepath = "res://UpgradesDescriptions.txt"
		var file = FileAccess.open("res://UpgradesDescriptions.txt", FileAccess.READ)
		while not file.eof_reached():
			lines.append(file.get_line())
			$UpgradeDesc.text = read_specific_line(Upgrade)

func UpdateIcon():
		var path = "res://Sprites/UpgradesIcon/UpgradeIcon" + str(Upgrade) + ".png"
		$UpgradeIcon.texture = load(path)
