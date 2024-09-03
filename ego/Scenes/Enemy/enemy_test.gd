extends CharacterBody2D

var playerVector = Vector2.ZERO

func _physics_process(delta):
	
	look_at(playerVector)
	
	move_and_slide()

func set_player_vector(playerPos: Vector2):
	playerVector = playerPos
	
