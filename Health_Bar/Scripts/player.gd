extends KinematicBody2D

var velocity = Vector2()
const SPEED = 400
const GRAVITY = 20
const HEIGHT_UP = -500
var attack_mode = false
onready var stats = $stats
onready var health_bar = $healthBar
#enemy_range variable is to check that enemy enter our player hurtbox
var enemy_range = false


func _input(event):
	# i have mentioned four animations which we have to create for attack of
	# our main player
	if event.is_action_pressed("ui_down"):
		attack_mode = false
	if event.is_action_pressed("attack_left"):
		$AnimatedSprite.play("attackLeft")
		attack_mode = true
		velocity.y = -100
	if event.is_action_pressed("attack_right"):
		$AnimatedSprite.play("attackRight")
		attack_mode = true
	if event.is_action_pressed("attack_lower_body"):
		$AnimatedSprite.play("attackLower")
		attack_mode = true
	if event.is_action_pressed("attack_upper_body"):
		$AnimatedSprite.play("attackUpper")
		attack_mode = true


func _physics_process(delta):
	velocity.y += GRAVITY
	#friction is added for the smooth movement of player
	var friction = false
	
	if Input.is_action_pressed("ui_right"):
		velocity.x = SPEED
		#AnimatedSprite is the node for our animations
		$AnimatedSprite.flip_h = false
		$AnimatedSprite.play("run")
	
	elif Input.is_action_pressed("ui_left"):
		velocity.x = -SPEED
		#flip_h is used to flip the direction of our player
		$AnimatedSprite.flip_h = true
		$AnimatedSprite.play("run")
	
	else:
		velocity.x = lerp(velocity.x,0,0.2)
		$AnimatedSprite.play("idle")
		friction = true
	
	if is_on_floor():
		if Input.is_action_pressed("ui_up"):
			velocity.y = HEIGHT_UP
		if friction == true:
			velocity.x = lerp(velocity.x,0,0.2)
	else:
		if velocity.y<0:
			$AnimatedSprite.play("jump")
		else:
			$AnimatedSprite.play("fall")
		if friction == true:
			velocity.x = lerp(velocity.x,0,0.05)
	
	if attack_mode == true:
		velocity.x = velocity.x*0.3
	
	move_and_slide(velocity,Vector2(0,-1))



func _on_health_no_health():
	#our player dies
	$AnimatedSprite.play("death")
	health_bar.on_health_updated(stats.health)
	queue_free()

#this hurtbox is for upper body
func _on_HurtBox_area_entered(area):
	stats.health -= 10
	health_bar.on_health_updated(stats.health)
