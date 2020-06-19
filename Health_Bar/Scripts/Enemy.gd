extends KinematicBody2D


export var GRAVITY = 20
onready var health = $health
onready var hitareaDetect = $HitAreaDetaect
var knockBack = Vector2.ZERO
var velocity = Vector2.ZERO

func _physics_process(delta):
	velocity.y += GRAVITY
#	knockBack = knockBack.move_toward(Vector2.ZERO,200*delta)
#	knockBack = move_and_slide(knockBack)
	if velocity.x == 0:
		$AnimatedSprite.play("idle")
	_defence()
	velocity = move_and_slide(velocity)

func _defence():
	if hitareaDetect._find_player():
		var animation_play =  hitareaDetect.player.get_child(0)
		if animation_play.animation == "attackLeft":
			$AnimatedSprite.play("punchLeft")
			velocity.y = 200
#		elif hitareaDetect.player.animation == "attackRight":
#			$AnimatedSprite.play("punchRight")
		else:
			pass


func _on_health_no_health():
	#our enemy dies
	$AnimatedSprite.play("death")
	queue_free()




func _on_HurtBox_area_entered(area):
	pass # Replace with function body.
