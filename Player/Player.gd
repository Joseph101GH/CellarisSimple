extends CharacterBody2D

# 'onready' variables for components.
@onready var damage_interval_timer = $DamageIntervalTimer
@onready var health_component = $HealthComponent
@onready var health_bar = $HealthBar
@onready var abilities = $Abilities
@onready var sprite = $Visuals/Sprite2D
@onready var velocity_component = $VelocityComponent
@onready var character_state_machine = $CharacterStateMachine



var input = Vector2.ZERO
var number_colliding_bodies = 0
var base_speed = 0


func _ready():
	base_speed = velocity_component.max_speed
	$HurtboxComponent.body_entered.connect(on_body_entered)
	$HurtboxComponent.body_exited.connect(on_body_exited)
	damage_interval_timer.timeout.connect(on_damage_interval_timer_timeout)
	health_component.health_changed.connect(on_health_changed)
	update_health_display()
	

func _process(delta):
	var movement_vector = get_movement_vector()
	var direction = movement_vector.normalized()
	velocity_component.accelerate_in_direction(direction)
	velocity_component.move(self)


# Handle physics-based movement.
func _physics_process(delta):
	handleInput()
	move_and_slide()
#	updateAnimation()


# Calculates the movement vector based on player input.
func get_movement_vector():
	input.x = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))
	input.y = int(Input.is_action_pressed("move_down")) - int(Input.is_action_pressed("move_up"))
	return input.normalized()


# Handles player input for movement.
func handleInput():
	var moveDirection = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = moveDirection * velocity_component.max_speed


func get_input_direction():
	var input_vec = Vector2.ZERO
	input_vec.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	input_vec.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	if input_vec != Vector2.ZERO:
		input_vec = input_vec.normalized()
	return input_vec


func update_health_display():
	health_bar.value = health_component.get_health_percent()


func on_body_entered(other_body: Node2D):
	number_colliding_bodies += 1
	check_deal_damage()


func on_body_exited(other_body: Node2D):
	number_colliding_bodies -= 1


func check_deal_damage():
	if number_colliding_bodies == 0 || !damage_interval_timer.is_stopped():
		return
	health_component.damage(1)
	damage_interval_timer.start()


func on_damage_interval_timer_timeout():
	check_deal_damage()


func on_health_changed():
	GameEvents.emit_player_damaged()
	update_health_display()
	$HitRandomStreamPlayer.play_random()


#func on_ability_upgrade_added(ability_upgrade: AbilityUpgrade, current_upgrades: Dictionary):
#	if ability_upgrade is Ability:
#		var ability = ability_upgrade as Ability
#		abilities.add_child(ability.ability_controller_scene.instantiate())
#	elif ability_upgrade.id == "player_speed":
#		velocity_component.max_speed = base_speed + (base_speed * current_upgrades["player_speed"]["quantity"] * .1)
