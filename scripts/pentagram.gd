extends Area2D
var State = 0
var joey = null
#@onready var Upgrade = $Upgrade1

func _process(delta):
	%PentagramFloor.position = global_position
	var OverlappingBody = get_overlapping_bodies()
	$LadyD.visible = false
	$LadyD/Upgrade1.disabled = true
	if OverlappingBody.size() > 0:
		joey = OverlappingBody.front()
		if (State == 1):
			$LadyD.visible = true
			$LadyD/Upgrade1.UpdateTitle()
			$LadyD/Upgrade1.disabled = false
			$LadyD/AnimatedSprite2D.play("LadyD")

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
	pass
