extends Node2D

## Intention is to properly rotate the bones in a way where they meet at a point


## Left arm length : 88 + 91 = 179
## Right arm length : 83 + 92 = 175 

var mouseVector : Vector2
var lastMouseVector : Vector2

var toggle = true

func _process(delta: float) -> void:
	
	if(Input.is_action_pressed("Fire")):
		mouseVector = to_local(get_global_mouse_position())
	if(Input.is_action_just_pressed("Dash")):
		toggle = !toggle
	
	if(lastMouseVector != mouseVector):
		
		## Left
		var segmentLength = $Skeleton2D/Body/LeftShoulder/Bicept/Elbow/Rotation/Forearm.get_length() + $Skeleton2D/Body/LeftShoulder/Bicept/Elbow/Rotation/Forearm/Wrist.get_length() + $Skeleton2D/Body/LeftShoulder/Bicept/Elbow/Rotation/Forearm/Wrist/Hand.get_length()
		var armLength =$Skeleton2D/Body/LeftShoulder/Bicept.get_length() + $Skeleton2D/Body/LeftShoulder/Bicept/Elbow.get_length() + $Skeleton2D/Body/LeftShoulder/Bicept/Elbow/Rotation.get_length() + segmentLength
		var scaleValue = segmentLength
		
		var distanceToMouseLeft = $Skeleton2D/Body/LeftShoulder.position.distance_to( mouseVector )
		var angleToLeft = atan( ( mouseVector.y - $Skeleton2D/Body/LeftShoulder.position.y ) / ( mouseVector.x ) ) + ( PI if mouseVector.x >= 0 else 0 )
		
		
		if(distanceToMouseLeft >= armLength):
			
			## Restors things to normal
			$Skeleton2D/Body/LeftShoulder.rotation = angleToLeft - PI / 2
			$Skeleton2D/Body/LeftShoulder/Bicept/Elbow/Rotation.rotation = 0
			
			$Skeleton2D/Body/LeftShoulder/Bicept.scale.y = 1
			$Skeleton2D/Body/LeftShoulder/Bicept/Elbow.scale.y = 1
			$Skeleton2D/Body/LeftShoulder/Bicept/Elbow/Rotation/Forearm.scale.y = 1
			$Skeleton2D/Body/LeftShoulder/Bicept/Elbow/Rotation/Forearm/Wrist.scale.y = 1
			
		else:
			
			scaleValue = ( segmentLength / 3 ) * pow( 1.0227, distanceToMouseLeft ) ## This gets the desired length of the segments
			$Skeleton2D/Body/LeftShoulder.rotation = asin( ( distanceToMouseLeft / 2 ) / scaleValue ) + angleToLeft + PI ## Shoulder
			$Skeleton2D/Body/LeftShoulder/Bicept/Elbow/Rotation.rotation = acos( ( distanceToMouseLeft / 2 ) / scaleValue ) * 2 ## Elbow
			## Math explination:
			##	Grabs the angle by assuming the two segmants are of equal length, so it can split the distance to mouse in half and treat it as two right angles
			
			## Change size of thing
			$Skeleton2D/Body/LeftShoulder/Bicept.scale.y = scaleValue/(armLength-segmentLength) #/ ($Skeleton2D/Body/LeftShoulder/Bicept.get_length())/(armLength-segmentLength))
			$Skeleton2D/Body/LeftShoulder/Bicept/Elbow.scale.y =  1 / $Skeleton2D/Body/LeftShoulder/Bicept.scale.y
			$Skeleton2D/Body/LeftShoulder/Bicept/Elbow/Rotation/Forearm.scale.y = scaleValue/segmentLength #/ ($Skeleton2D/Body/LeftShoulder/Bicept.get_length())/(armLength-segmentLength))
			$Skeleton2D/Body/LeftShoulder/Bicept/Elbow/Rotation/Forearm/Wrist.scale.y =  1 / $Skeleton2D/Body/LeftShoulder/Bicept/Elbow/Rotation/Forearm.scale.y
			## Math explination:
			##	Calculates the scale ratio, then multiplies it by the ratio of the scaled bone to the bone segment, 
			##	Then the child bone of the scaled object is conversly scaled to balance the rotation scale problem.
			
		
		## Left		
		var distanceToMouseRight = $Skeleton2D/Body/RightShoulder.position.distance_to( mouseVector )
		var angleToRight = atan( ( mouseVector.y - $Skeleton2D/Body/RightShoulder.position.y ) / ( mouseVector.x ) ) + ( PI if mouseVector.x >= 0 else 0 )
		
		
		if(distanceToMouseRight >= armLength):
			
			## Restors things to normal
			$Skeleton2D/Body/RightShoulder.rotation = angleToRight - PI / 2
			$Skeleton2D/Body/RightShoulder/Bicept/Elbow/Rotation.rotation = 0
			
			$Skeleton2D/Body/RightShoulder/Bicept.scale.y = 1
			$Skeleton2D/Body/RightShoulder/Bicept/Elbow.scale.y = 1
			$Skeleton2D/Body/RightShoulder/Bicept/Elbow/Rotation/Forearm.scale.y = 1
			$Skeleton2D/Body/RightShoulder/Bicept/Elbow/Rotation/Forearm/Wrist.scale.y = 1
			
		else:
			
			scaleValue = ( segmentLength / 3 ) * pow( 1.0227, distanceToMouseRight ) ## This gets the desired length of the segments
			$Skeleton2D/Body/RightShoulder.rotation = asin( ( distanceToMouseRight / 2 ) / scaleValue) + angleToRight + PI ## Shoulder
			$Skeleton2D/Body/RightShoulder/Bicept/Elbow/Rotation.rotation = acos( ( distanceToMouseRight / 2 ) / scaleValue) * 2 ## Elbow
			## Math explination:
			##	Grabs the angle by assuming the two segmants are of equal length, so it can split the distance to mouse in half and treat it as two right angles
			
			## Change size of thing
			$Skeleton2D/Body/RightShoulder/Bicept.scale.y = scaleValue/(armLength-segmentLength) #/ ($Skeleton2D/Body/LeftShoulder/Bicept.get_length())/(armLength-segmentLength))
			$Skeleton2D/Body/RightShoulder/Bicept/Elbow.scale.y =  1 / $Skeleton2D/Body/RightShoulder/Bicept.scale.y
			$Skeleton2D/Body/RightShoulder/Bicept/Elbow/Rotation/Forearm.scale.y = scaleValue/segmentLength #/ ($Skeleton2D/Body/LeftShoulder/Bicept.get_length())/(armLength-segmentLength))
			$Skeleton2D/Body/RightShoulder/Bicept/Elbow/Rotation/Forearm/Wrist.scale.y =  1 / $Skeleton2D/Body/RightShoulder/Bicept/Elbow/Rotation/Forearm.scale.y
			## Math explination:
			##	Calculates the scale ratio, then multiplies it by the ratio of the scaled bone to the bone segment, 
			##	Then the child bone of the scaled object is conversly scaled to balance the rotation scale problem.
