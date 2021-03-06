extends Actor

export var stomp_velocity = 1000.0
const enemy_scene = preload ("res://source/Enemy.tscn")
var count: int = 0

func _ready():
	set_physics_process(true)
	set_process_input(true)


func _on_EnemyDetector_area_entered(area) -> void:
	_velocity = _calculate_stomp_velocity(_velocity, stomp_velocity)

func _on_EnemyDetector_body_entered(body):
	queue_free()


func _physics_process(delta:  float) -> void:
	
	count += 1
	if count % 400 == 0:
		var enemy = enemy_scene.instance()
		get_tree().get_root().add_child(enemy)
		enemy.set_position(get_parent().get_node("Ancor").get_global_position())
	
	var is_jump_interrupted: = Input.is_action_just_released("jump") and _velocity.y < 0.0
	var direction: = get_direction()
	
	_velocity = _calculate_move_velocity(_velocity, direction, speed, is_jump_interrupted)
	_velocity = move_and_slide(_velocity, FLOOR_NORMAL)


func get_direction() -> Vector2:
	
	return Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		-1.0 if Input.is_action_just_pressed("jump") and  is_on_floor() else 1.0
	)

func _calculate_move_velocity(
		linear_velocity: Vector2,
		direction: Vector2,
		speed: Vector2,
		is_jump_interrupted: bool
	) -> Vector2:
	
	var out: = linear_velocity
	out.x = speed.x * direction.x
	out.y += gravity * get_physics_process_delta_time()
	if direction.y == -1.0:
		out.y = speed.y * direction.y
	if is_jump_interrupted:
		out.y = 0.0
	
	return out

func _calculate_stomp_velocity (linear_velocity: Vector2, impulse: float) -> Vector2:
	var out: = linear_velocity
	out.y = -impulse
	return out
