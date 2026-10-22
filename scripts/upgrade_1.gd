extends TextureButton
var Upgrade = 1
var Title = ""
var Desc = ""
var lines = []
var filepath
const DESCRIPTIONPATH = "res://UpgradesDescriptions.txt"
var json

func Update():
	UpdateTitle()
	UpdateDesc()
	UpdateIcon()

func UpdateTitle():
	var jsonfilepath = "res://upgrades.json"
	var json_as_text = FileAccess.get_file_as_string(jsonfilepath)
	json = JSON.parse_string(json_as_text)
	$UpgradeTitle.text = str(json[Upgrade].name)

#func read_specific_line(line_number: int) -> String:
	## Open the file in read mode
	#var file = FileAccess.open(filepath, FileAccess.READ)
	#if not file:
		#return "ERROR NOT FILE"
		#
	## Read the whole file and split it into individual lines
	#var all_text = file.get_as_text()
	#var lines = all_text.split("\n")
	#
	## Check if the requested line index exists (0-indexed)
	#if line_number >= 0 and line_number < lines.size():
		#return lines[line_number]
	#else:
		#return "Line number out of bounds."

func UpdateDesc():
	var jsonfilepath = "res://upgrades.json"
	var json_as_text = FileAccess.get_file_as_string(jsonfilepath)
	json = JSON.parse_string(json_as_text)
	$UpgradeDesc.text = str(json[Upgrade].description)

func UpdateIcon():
		var path = "res://Sprites/UpgradesIcon/UpgradeIcon" + str(Upgrade) + ".png"
		$UpgradeIcon.texture = load(path)
