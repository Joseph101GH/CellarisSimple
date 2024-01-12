extends CharacterBody2D

# Using 'onready' to initialize variables when the node and its children are ready
@onready var velocity_component = $VelocityComponent
@onready var visuals = $Visuals


func _ready():
	# Connecting the 'hit' signal from the HurtboxComponent to the 'on_hit' function
	$HurtboxComponent.hit.connect(on_hit)


func _physics_process(delta):
	# Process movement logic here.
	move_and_slide()


func on_hit():
	# Play a random audio on hit
	$HitRandomAudioPlayerComponent.play_random()
