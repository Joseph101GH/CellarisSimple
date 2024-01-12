extends CharacterBody2D

@onready var velocity_component = $VelocityComponent
@onready var visuals = $Visuals


func _ready():
	$HurtboxComponent.hit.connect(on_hit)


func _physics_process(delta):
	move_and_slide()
	
#	if velocity.length() > 0:
#		$EnemyAnimationPlayer.play("fly")
		
	if velocity.x > 0:
		$Visuals/Sprite2D.flip_h = false
	else:
		$Visuals/Sprite2D.flip_h = true


func on_hit():
	$HitRandomAudioPlayerComponent.play_random()
