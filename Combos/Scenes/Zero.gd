extends KinematicBody2D

var movement = Vector2();
var up = Vector2(0,-1);
var AttackPoints = 3;
func _process(delta):
	
	if Input.is_action_just_pressed("Attack") && AttackPoints == 3:
		$AttackResetTimer.start();
		$ZeroAnimation.play("Attack");
		AttackPoints = AttackPoints - 1;
	elif Input.is_action_just_pressed("Attack") && AttackPoints == 2:
		$AttackResetTimer.start();
		$ZeroAnimation.play("Attack 1");
		AttackPoints = AttackPoints - 1;
	elif Input.is_action_just_pressed("Attack") && AttackPoints ==1:
		$AttackResetTimer.start();
		$ZeroAnimation.play("Jump Attack");
		AttackPoints = AttackPoints - 1;
	
	movement = move_and_slide(movement,up);

func _on_ZeroAnimation_animation_finished():
	if $ZeroAnimation.animation == "Attack" || $ZeroAnimation.animation == "Attack 1":
		$ZeroAnimation.play("Idle");
	elif $ZeroAnimation.animation == "Jump Attack":
		$ZeroAnimation.play("Idle");
		AttackPoints = 3;	


func _on_AttackResetTimer_timeout():
	AttackPoints = 3;
