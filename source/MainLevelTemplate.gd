extends Node2D

onready var Player = "res://source/Player.tscn/"
onready var Enemy  = "res://source/Enemy.tscn/"
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	if Player.stats.health == 0:
		get_tree().change_scene("Youlost.tscn")
	if Enemy.stats.health == 0:
		get_tree().change_scene("Youlost.tscn")	

	
