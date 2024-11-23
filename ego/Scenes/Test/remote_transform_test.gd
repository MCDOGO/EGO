extends Node2D

## Intention is to properly rotate the bones in a way where they meet at a point

@export_file("*.png") var texture

@export var weapon: Weapon_Gun

## Left arm length : 88 + 91 = 179
## Right arm length : 83 + 92 = 175 


func _ready() -> void:
	for child in $CanvasGroup/Sprites.get_children():
		if(child is Sprite2D):
			child.texture = load(texture)


var mouseVectorLeft : Vector2 = Vector2.ZERO
var lastMouseVectorLeft : Vector2 = Vector2.ZERO

var mouseVectorRight : Vector2
var lastMouseVectorRight : Vector2

func _process(delta: float) -> void:
	
	if(Input.is_action_pressed("Fire")):
		$CanvasGroup/Sprites/LeftMark.position = get_local_mouse_position()
	mouseVectorLeft = $CanvasGroup/Sprites/LeftMark.position
	if(Input.is_action_pressed("Melee")):
		$CanvasGroup/Sprites/RightMark.position = get_local_mouse_position()
	mouseVectorRight = $CanvasGroup/Sprites/RightMark.position
	
	if(lastMouseVectorLeft != mouseVectorLeft):
		
		## Left
		var maxLengthLeft = 26 * 2
		var boneLengthLeft = 26 ## Base bone length for left arm
		var scaleValueLeft = boneLengthLeft ## The calculated scale value to use in calculations
		
		var distanceToMouseLeft = $CanvasGroup/Sprites/LeftBicept.position.distance_to((mouseVectorLeft))
		var angleToLeft = atan( ( mouseVectorLeft.y) / ( mouseVectorLeft.x + 14) ) + ( PI if mouseVectorLeft.x + 14 >= 0 else 0 )
		
		if(distanceToMouseLeft >= maxLengthLeft):
		
			$CanvasGroup/Sprites/LeftBicept.rotation = angleToLeft
			$CanvasGroup/Sprites/LeftForearm.rotation = $CanvasGroup/Sprites/LeftBicept.rotation
			
			$CanvasGroup/Sprites/LeftBicept.scale = Vector2.ONE
			$CanvasGroup/Sprites/LeftForearm.position = Vector2(0,-boneLengthLeft)
			
		else:
			
			scaleValueLeft = ( boneLengthLeft / 2.3 ) * pow(1.0162, distanceToMouseLeft) 
			$CanvasGroup/Sprites/LeftBicept.rotation = asin( ( distanceToMouseLeft / 2 ) / scaleValueLeft ) + angleToLeft - PI/2 ## Shoulder
			$CanvasGroup/Sprites/LeftForearm.rotation = $CanvasGroup/Sprites/LeftBicept.rotation + acos( ( distanceToMouseLeft / 2 ) / scaleValueLeft ) * 2 ## Elbow
			
			## Change size of thing
			$CanvasGroup/Sprites/LeftBicept.scale.x = scaleValueLeft / boneLengthLeft
			
			## Eccential:
			lastMouseVectorLeft = mouseVectorLeft
		
	if(lastMouseVectorRight != mouseVectorRight):
		
		var maxLengthRight = 26 * 2
		var boneLengthRight = 26 ## Base bone length for left arm
		var scaleValueRight = boneLengthRight ## The calculated scale value to use in calculations
		
		var distanceToMouseRight = $CanvasGroup/Sprites/RightBicept.position.distance_to((mouseVectorRight))
		var angleToRight = atan( ( mouseVectorRight.y) / ( mouseVectorRight.x - 14) ) + ( PI if mouseVectorRight.x - 14 >= 0 else 0 )
		
		if(distanceToMouseRight >= maxLengthRight):
		
			$CanvasGroup/Sprites/RightBicept.rotation = angleToRight + PI
			$CanvasGroup/Sprites/RightForearm.rotation = $CanvasGroup/Sprites/RightBicept.rotation
			
			$CanvasGroup/Sprites/RightBicept.scale = Vector2.ONE
			$CanvasGroup/Sprites/RightForearm.position = Vector2(0,-boneLengthRight)
			
		else:
			
			scaleValueRight = ( boneLengthRight / 2.3 ) * pow(1.0162, distanceToMouseRight) 
			$CanvasGroup/Sprites/RightBicept.rotation = -asin( ( distanceToMouseRight / 2 ) / scaleValueRight ) + angleToRight - PI/2 ## Shoulder
			$CanvasGroup/Sprites/RightForearm.rotation = $CanvasGroup/Sprites/RightBicept.rotation + -acos( ( distanceToMouseRight / 2 ) / scaleValueRight ) * 2 ## Elbow
			
			## Change size of thing
			$CanvasGroup/Sprites/RightBicept.scale.x = scaleValueRight / boneLengthRight
		
		## Eccential:
		lastMouseVectorRight = mouseVectorRight
