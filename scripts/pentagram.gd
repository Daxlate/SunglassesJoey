extends Area2D
var State = 0

func _process(delta):
	%PentagramFloor.position = global_position
	var OverlappingBody = get_overlapping_bodies()
	if OverlappingBody.size() > 0:
		if (Input.is_action_pressed("shoot") && State == 1):
			TurnOff()
			$Timer.start()
			$Label.text = "asd"
		pass

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
