extends Area2D
var State = 0
var joey = null
var generated_upgrade = false
var buttonstate = false
var upgrade1 = null
var upgrade2 = null
var times = 0
var vis = false

func _process(_delta):
	%PentagramFloor.position = position
	%ExtraEffects.position = position + Vector2(1, -12)
	var OverlappingBody = get_overlapping_bodies()
	Everythingvisibility(false)
	if OverlappingBody.size() > 0:
		joey = OverlappingBody.front()
		if (generated_upgrade == false):
			generate_upgrade(1)
			generate_upgrade(2)
		if (State == 1):
			Everythingvisibility(true)
			%Upgrade1.Update()
			%Upgrade2.Update()
			$LadyD/AnimatedSprite2D.play("LadyD")

func Everythingvisibility(state: bool):
	$LadyD/ColorRect.visible = state
	$LadyD/AnimatedSprite2D.visible = state
	$LadyD/Upgrade1/UpgradeDesc.visible = state
	$LadyD/Upgrade1/UpgradeIcon.visible = state
	$LadyD/Upgrade1/UpgradeTitle.visible = state
	$LadyD/Upgrade2/UpgradeDesc.visible = state
	$LadyD/Upgrade2/UpgradeIcon.visible = state
	$LadyD/Upgrade2/UpgradeTitle.visible = state
	
	var buttonstate = state
	if state:
		%Upgrade1.texture_normal = load("res://Sprites/UpgradesIcon/UpgradesHolder1.png")
		%Upgrade2.texture_normal = load("res://Sprites/UpgradesIcon/UpgradesHolder1.png")
		vis = true
	else:
		%Upgrade1.texture_normal = load("res://Sprites/UpgradesIcon/UpgradesHolder3.png")
		%Upgrade2.texture_normal = load("res://Sprites/UpgradesIcon/UpgradesHolder3.png")
		vis = false
		
	

func _on_timer_timeout():
	TurnOn()
func TurnOff():
	State = 0
	%PentagramFloor.play("Off")
func TurnOn():
	State = 1
	upgrade1 = null
	generated_upgrade = false
	%PentagramFloor.play("LightUp")
	%ExtraEffects.play("Animation")
func _on_pentagram_floor_animation_finished():
	if State == 1:
		%PentagramFloor.play("On")
func _on_extra_effects_animation_finished():
	%ExtraEffects.play("Off")
func generate_upgrade(which: int):
	times += 1
	var randomupgrade = randi_range(0,2)
	if (joey.upgrades.count(false) > 1):
		while (joey.upgrades[randomupgrade]):
			randomupgrade = randi_range(0,1)
		if (upgrade1 == null):
			upgrade1 = randomupgrade
		elif (upgrade1 == randomupgrade):
			while (upgrade1 == randomupgrade):
				randomupgrade = randi_range(0,1)
	var upgradebutton = get_node("%Upgrade" + str(which))
	upgradebutton.Upgrade = randomupgrade
	generated_upgrade = true


func _on_upgrade_pressed(source: BaseButton) -> void:
	if vis:
		TurnOff()
		$Timer.start()
		if (joey != null):
			match (source.Upgrade):
				0:
					#joey.upgrades[0] = true
					joey.speed += 100
				1:
					#joey.upgrades[1] = true
					joey.attack += 3 
				2:
					joey.upgrades[2] = true
					joey.cooltime = joey.cooltime * 0.75
