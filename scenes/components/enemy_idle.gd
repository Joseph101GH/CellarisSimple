extends State
class_name EnemyIdle

var enemy: CharacterBody2D
@export var move_speed := 10.0
@export var start_chase_distance = 100

var player : CharacterBody2D
var move_direction : Vector2
var wander_time : float

func set_parameters(_enemy: CharacterBody2D):
	enemy = _enemy
	player = get_tree().get_first_node_in_group("player")

func Enter():
	randomize_wander()

func randomize_wander():
	move_direction = Vector2(randf_range(-2, 2), randf_range(-2, 2)).normalized()
	wander_time = randf_range(1, 5)

func Update(delta: float):
	if wander_time > 0:
		wander_time -= delta
	else:
		randomize_wander()

func Physics_Update(delta: float):
	if not enemy:
		return

	enemy.velocity = move_direction * move_speed

	# Rotate the enemy to face the direction of movement
	rotate_enemy_to_direction(move_direction)

	var direction = player.global_position - enemy.global_position
	if direction.length() < start_chase_distance: # Distance to start following
		Transitioned.emit(self, "follow")


# New function to handle rotation
func rotate_enemy_to_direction(direction: Vector2):
	if direction != Vector2.ZERO:
		enemy.rotation = direction.angle()
