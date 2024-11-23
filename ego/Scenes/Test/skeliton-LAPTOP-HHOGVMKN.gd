extends Node2D

## Intention is to properly rotate the bones in a way where they meet at a point


## Left arm length : 88 + 91 = 179
## Right arm length : 83 + 92 = 175 

var mouseVector : Vector2
var lastMouseVector : Vector2

var toggle = true

func _process(delta: float) -> void:
	
	if(Input.is_action_pressed("Fire")):
		mouseVector = get_global_mouse_position()
	if(Input.is_action_just_pressed("Dash")):
		toggle = !toggle
		print("foire")
	
	if(lastMouseVector != mouseVector):
		
		## Left
		var maxLengthLeft = $Skeleton2D/Body/LeftShoulder.get_length() + $Skeleton2D/Body/LeftShoulder/LeftElbow.get_length()
		var boneLengthLeft = 91 ## Base bone length for left arm
		var scaleValueLeft = boneLengthLeft ## The calculated scale value to use in calculations
		
		var distanceToMouseLeft = $Skeleton2D/Body/LeftShoulder.position.distance_to( mouseVector )
		var angleToLeft = atan( ( mouseVector.y + 72 ) / ( mouseVector.x ) ) + ( PI if mouseVector.x >= 0 else 0 )
		
		if(distanceToMouseLeft >= maxLengthLeft):
		
			$Skeleton2D/Body/LeftShoulder.rotation = angleToLeft - PI / 2
			$Skeleton2D/Body/LeftShoulder/LeftElbow.rotation = 0
			
			$Skeleton2D/Body/LeftShoulder.rest.y.y = 1
			$Skeleton2D/Body/LeftShoulder/LeftElbow.position = Vector2(0,-boneLengthLeft)
			
		else:
			
			scaleValueLeft = ( boneLengthLeft / 2 ) * pow( 1.00388, distanceToMouseLeft ) 
			$Skeleton2D/Body/LeftShoulder.rotation = asin( ( distanceToMouseLeft / 2 ) / scaleValueLeft ) + angleToLeft + PI ## Shoulder
			$Skeleton2D/Body/LeftShoulder/LeftElbow.rotation = acos( ( distanceToMouseLeft / 2 ) / scaleValueLeft ) * 2 ## Elbow
			
			## Change size of thing
			$Skeleton2D/Body/LeftShoulder.scale.y = scaleValueLeft / boneLengthLeft

		
		## Right
		var maxLengthRight = $Skeleton2D/Body/RightShoulder.get_length() + $Skeleton2D/Body/RightShoulder/RightElbow.get_length()
		var boneLengthRight = 91 ## Base bone length for left arm
		var scaleValueRight = 91
		
		var distanceToMouseRight = ($Skeleton2D/Body/RightShoulder.position).distance_to(mouseVector)
		var angleToRight = atan((mouseVector.y-72)/(mouseVector.x)) + (PI if mouseVector.x>=0 else 0)
		if(distanceToMouseRight >= maxLengthRight):
			$Skeleton2D/Body/RightShoulder.rotation = angleToRight + PI/2
			$Skeleton2D/Body/RightShoulder/RightElbow.rotation = 0
			$Skeleton2D/Body/RightShoulder.scale = Vector2.ONE
		else:
			scaleValueRight = ( boneLengthRight / 2 ) * pow( 1.00388, distanceToMouseRight ) 
			$Skeleton2D/Body/RightShoulder.rotation = -asin((distanceToMouseRight/2)/scaleValueRight) + angleToRight + PI## Shoulder
			$Skeleton2D/Body/RightShoulder/RightElbow.rotation = -acos((distanceToMouseRight/2)/scaleValueRight)*2 ## Elbow
			
			## Change size of thing
			$Skeleton2D/Body/RightShoulder.scale.y = scaleValueRight/boneLengthRight
		
		## Eccential:
		lastMouseVector = mouseVector
