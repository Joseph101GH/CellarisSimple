extends State
class_name EnemyFollow

var enemy: CharacterBody2D
var move_speed := 100
@export var follow_distance := 35 # how close to get
@export var release_distance := 300 # how far you have to run to escape

var player: CharacterBody2D

func set_parameters(_enemy: CharacterBody2D):
	enemy = _enemy
	player = get_tree().get_first_node_in_group("player")

func Enter():
	pass

func Physics_Update(delta: float):
	var direction = player.global_position - enemy.global_position

	if direction.length() > follow_distance: # How close to get before attacking
		enemy.velocity = direction.normalized() * move_speed
	else:
		enemy.velocity = Vector2()

	# Rotate the enemy to face the direction of movement
	rotate_enemy_to_direction(enemy.velocity)

	if direction.length() > release_distance: # Distance to break contact
		Transitioned.emit(self, "idle")


# New function to handle rotation
func rotate_enemy_to_direction(direction: Vector2):
	if direction != Vector2.ZERO:
		enemy.rotation = direction.angle()
