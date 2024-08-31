extends CharacterBody2D


const SPEED = 300.0
## const deltaBalancer = 60

func _physics_process(delta):
	
	## velocity = Vector2(Input.is_action_pressed("Right") - Input.is_action_pressed("Left"), Input.is_action_pressed("Up") - Input.is_action_pressed("Down"))
	velocity.x = Input.get_axis("Left", "Right")
	velocity.y = Input.get_axis("Up", "Down")
	velocity = velocity.normalized()
	velocity*=SPEED##*delta##*deltaBalancer
	print(velocity)
	
	
	
	look_at(get_global_mouse_position())
	
	move_and_slide()
