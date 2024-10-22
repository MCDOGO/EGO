extends Node2D

## Intention is to properly rotate the bones in a way where they meet at a point


## Left arm length : 88 + 91 = 179
## Right arm length : 83 + 92 = 175 

var mouseVector : Vector2
var lastMouseVector : Vector2

func _process(delta: float) -> void:
	
	if(Input.is_action_pressed("Fire")):
		mouseVector = to_local(get_global_mouse_position())
	
	if(lastMouseVector != mouseVector ):
		var tempVect: Vector2 = $Skeleton2D/Body/LeftShoulder.position
		mouseVector.x += $Skeleton2D/Body/LeftShoulder.position.x
		mouseVector.y -= $Skeleton2D/Body/LeftShoulder.position.y
		
		#var distanceToMouseLeft = sqrt(pow(mouseVector.x+tempVect.x, 2) + pow(mouseVector.y-tempVect.y, 2))
		var distanceToMouseLeft = ($Skeleton2D/Body/LeftShoulder.position).distance_to(mouseVector)
		print(distanceToMouseLeft)
		
		if(distanceToMouseLeft >= 179):
			$Skeleton2D/Body/LeftShoulder.rotation = $Skeleton2D/Body.get_angle_to(mouseVector) + PI/2
			$Skeleton2D/Body/LeftShoulder/LeftElbow.rotation = 0
		else:
			
			var x = 88
			var y = 91
			var z = distanceToMouseLeft
			
			
			## Shoulder
			#$Skeleton2D/Body/LeftShoulder.rotation = 0
			
			var X = acos(((x*x) - (z*z) - (y*y)) / (-2 * z * y)) ## Angle for Shoulder
			var Z = asin(z * sin(X) / x) ## Angle of the length
			
			#$Skeleton2D/Body/LeftShoulder.rotation = X + $Skeleton2D/Body/LeftShoulder.position.angle_to(mouseVector) - PI/2
			$Skeleton2D/Body/LeftShoulder.rotation = acos((z/2)/91) + $Skeleton2D/Body/LeftShoulder.position.angle_to(mouseVector) - PI/2
			
			## Elbow
			if(distanceToMouseLeft > 91 || true):
				#$Skeleton2D/Body/LeftShoulder/LeftElbow.rotation = acos(((z*z) - (x*x) - (y*y)) / (-2 * x * y))
				
				#$Skeleton2D/Body/LeftShoulder/LeftElbow.rotation = asin(x/(sin(X) * z))
				
				$Skeleton2D/Body/LeftShoulder/LeftElbow.rotation = asin((z/2)/91)*2
				
			else:
				pass
				
			pass
		
		## Eccential:
		lastMouseVector = mouseVector
