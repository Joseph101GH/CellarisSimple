extends CharacterBody2D

@onready var damage_interval_timer = $DamageIntervalTimer
@onready var health_component = $HealthComponent
@onready var health_bar = $HealthBar
@onready var abilities = $Abilities
@onready var sprite = $Visuals/Sprite2D
@onready var velocity_component = $VelocityComponent

var input = Vector2.ZERO

var number_colliding_bodies = 0
var base_speed = 0


func _ready():
	base_speed = velocity_component.max_speed
#	$HurtboxComponent.body_entered.connect(on_body_entered)
#	$HurtboxComponent.body_exited.connect(on_body_exited)
#	damage_interval_timer.timeout.connect(on_damage_interval_timer_timeout)
#	health_component.health_changed.connect(on_health_changed)
#	update_health_display()
	

func _process(delta):
	var movement_vector = get_movement_vector()
	var direction = movement_vector.normalized()
	velocity_component.accelerate_in_direction(direction)
	velocity_component.move(self)
	
	

func handleInput():
	var moveDirection = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = moveDirection * velocity_component.max_speed



func _physics_process(delta):
	handleInput()
	move_and_slide()
#	updateAnimation()	
	

func get_movement_vector():
	input.x = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))
	input.y = int(Input.is_action_pressed("move_down")) - int(Input.is_action_pressed("move_up"))
	return input.normalized()
	
	
#func updateAnimation():
#	var direction = "down"
#	if velocity.x < 0: direction = "left"
#	if velocity.x > 0: direction = "right"
#	if velocity.y < 0: direction = "up"
	



#func check_deal_damage():
#	if number_colliding_bodies == 0 || !damage_interval_timer.is_stopped():
#		return
#	health_component.damage(1)
#	damage_interval_timer.start()

#
#func update_health_display():
#	health_bar.value = health_component.get_health_percent()


#func on_body_entered(other_body: Node2D):
#	number_colliding_bodies += 1
#	check_deal_damage()
#
#
#func on_body_exited(other_body: Node2D):
#	number_colliding_bodies -= 1
#
#
#func on_damage_interval_timer_timeout():
#	check_deal_damage()
#
#
#func on_health_changed():
#	GameEvents.emit_player_damaged()
##	update_health_display()
#	$HitRandomStreamPlayer.play_random()


#func on_ability_upgrade_added(ability_upgrade: AbilityUpgrade, current_upgrades: Dictionary):
#	if ability_upgrade is Ability:
#		var ability = ability_upgrade as Ability
#		abilities.add_child(ability.ability_controller_scene.instantiate())
#	elif ability_upgrade.id == "player_speed":
#		velocity_component.max_speed = base_speed + (base_speed * current_upgrades["player_speed"]["quantity"] * .1)



