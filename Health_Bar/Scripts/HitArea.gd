extends Area2D

var player = null

func _find_player():
	return player!=null

func _on_HitArea_body_entered(body):
	player = body


func _on_HitArea_body_exited(body):
	player = null
