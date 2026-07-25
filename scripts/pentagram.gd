extends Area2D
var State = 0
var joey = null
var buttonstate = false
#@onready var Upgrade = $Upgrade1

func _process(delta):
	%PentagramFloor.position = global_position
	var OverlappingBody = get_overlapping_bodies()
	Everythingvisibility(false)
	if OverlappingBody.size() > 0:
		joey = OverlappingBody.front()
		if (State == 1):
			Everythingvisibility(true)
			%Upgrade1.UpdateTitle()
			$LadyD/AnimatedSprite2D.play("LadyD")

func Everythingvisibility(state: bool):
	$LadyD/ColorRect.visible = state
	$LadyD/AnimatedSprite2D.visible = state
	$LadyD/Upgrade1/UpgradeDesc1.visible = state
	$LadyD/Upgrade1/UpgradeIcon1.visible = state
	$LadyD/Upgrade1/UpgradeTitle1.visible = state
	
	var buttonstate = state
	if state:
		%Upgrade1.texture_normal = load("res://Sprites/UpgradesIcon/UpgradesHolder1.png")
	else:
		%Upgrade1.texture_normal = load("res://Sprites/UpgradesIcon/UpgradesHolder3.png")
		
	

func _on_timer_timeout():
	$Label.text = "yippe"
	TurnOn()

func TurnOff():
	State = 0
	%PentagramFloor.play("Off")
func TurnOn():
	State = 1
	%PentagramFloor.play("LightUp")
	%ExtraEffects.play("Animation")

func _on_pentagram_floor_animation_finished():
	if State == 1:
		%PentagramFloor.play("On")
		$Label.text = "sauce"

func _on_extra_effects_animation_finished():
	%ExtraEffects.play("Off")


func _on_upgrade_1_pressed() -> void:
	TurnOff()
	$Timer.start()
	$Label.text = "SASDASD"
	if (joey != null):
		var where = joey.upgrades.size() + 1
		joey.upgrades[0] = true
		joey.speed += 100


func _on_button_pressed() -> void:
	if buttonstate:
		TurnOff()
		$Timer.start()
		$Label.text = "SASDASD"
		if (joey != null):
			var where = joey.upgrades.size() + 1
			joey.upgrades[0] = true
			joey.speed += 100
