extends Control


onready var health_under = $healthUnder
onready var health_over = $healthOver
onready var tween_progress = $Tween
export var healthy_colour = Color.green
export var caution_colour = Color.yellow
export var danger_colour = Color.red


func on_health_updated(health):
	health_over.value = health
	if health_over.value >=50:
		health_over.tint_progress = healthy_colour
	elif health_over.value < 50 and health_over.value>=20:
		health_over.tint_progress = caution_colour
	else:
		health_over.tint_progress = danger_colour
	tween_progress.interpolate_property(health_under,"value",health_under.value,health,0.3,Tween.TRANS_SINE,Tween.EASE_IN_OUT,0.25)
	tween_progress.start()

func on_max_health_updated(max_health):
	health_over.max_value = max_health
