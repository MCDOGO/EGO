extends Node2D

## Intention is to properly rotate the bones in a way where they meet at a point

@export_file("*.png") var texture

@export var weapon: Weapon_Gun

@export var debugFreeMove = false

var mouseVectorLeft : Vector2 = Vector2.ZERO
var lastMouseVectorLeft : Vector2 = Vector2.DOWN

var mouseVectorRight : Vector2
var lastMouseVectorRight : Vector2 = Vector2.DOWN

##	Weapon sprite movenment factors
## Weapon sprite drag for movenment and recoil
var collectiveDrag : Vector2 ## Final value added to weapon
var softMaxDrag : Vector2 ## The max ammount of drag based on movenment speed
var hardMaxDrag : Vector2 ## The absolute maximum ammount of drag allowed based on previous actions
var movenmentDragMax : Vector2
var movenmentDrag : Vector2 ## (in the opposite direction of the movenment) 
var recoilDrag : float ## Only takes place Vetically

## Sway to left and right while moving (more sway when moving vertically)
var sway : float ## Final position of the sway
var swayvelocity : float
var terminalSway : float ## Max speed you can sway
var swayAcceleration : float
var swayLimit : Vector2 ## Limit of x before sway direction swaps
var swayDirection : bool = true ## Direction of sway



## Actually, not this: --Instantly remove sway and horizontal drag when firing--
## Keep sway and such to encourage players to stop moving when shooting, adding a level of tactics, 
## despite the accuracy not being super thrown off (negligable in some cases)


func _ready() -> void:
	var tempLoad = load(texture)
	for child in $Sprites.get_children():
		if(child is Sprite2D):
			child.texture = tempLoad
	$Sprites/LHandOffset/LeftHand.texture = tempLoad
	$Sprites/RHandOffset/RightHand.texture = tempLoad
	
	if(debugFreeMove):
		animation = DEBUGFREE
	
	_process(0.0)


func _process(delta: float) -> void:
	
	match(animation):
		IDLE: ## Change later if necissary
		## Keep in mind to apply IDLE after both hands have moved into position and are locked
			
			## Left hand
			$Sprites/LHandOffset/LeftHand.position = weapon.leftHandRest + weapon.sprite_positioning
			$Sprites/LHandOffset/LeftHand.rotation = deg_to_rad(weapon.leftRot)
			$Sprites/LHandOffset/LeftHand.frame = 16 + weapon.leftAnim
			mouseVectorLeft = $Sprites/LHandOffset/LeftHand.position
			
			## Right hand
			$Sprites/RHandOffset/RightHand.position = weapon.rightHandRest + weapon.sprite_positioning
			$Sprites/RHandOffset/RightHand.rotation = deg_to_rad(weapon.rightRot)
			$Sprites/RHandOffset/RightHand.frame = 16 + weapon.rightAnim
			mouseVectorRight = $Sprites/RHandOffset/RightHand.position
		
		DEBUGFREE:
			
			$Sprites/LHandOffset/LeftHand.frame = 16 + weapon.leftAnim
			$Sprites/RHandOffset/RightHand.frame = 16 + weapon.rightAnim
			
			if(Input.is_action_pressed("Fire")):
				$Sprites/LHandOffset/LeftHand.position = get_global_mouse_position()
				mouseVectorLeft = $Sprites/LHandOffset/LeftHand.position
			
			if(Input.is_action_pressed("Melee")):
				$Sprites/RHandOffset/RightHand.position = get_global_mouse_position()
				mouseVectorRight = $Sprites/RHandOffset/RightHand.position
	
	swayAndDrag()
	simpleCalculations()
	#if(Input.is_action_pressed("Fire")):
		#$Sprites/LeftHand.position = get_local_mouse_position()
	#


func simpleCalculations():
	
	if(lastMouseVectorLeft != mouseVectorLeft):
		
		## Left
		var maxLengthLeft = 26 * 2
		var boneLengthLeft = 26 ## Base bone length for left arm
		var scaleValueLeft = boneLengthLeft ## The calculated scale value to use in calculations
		
		var distanceToMouseLeft = $Sprites/LeftBicept.position.distance_to((mouseVectorLeft))
		var angleToLeft = atan( ( mouseVectorLeft.y) / ( mouseVectorLeft.x + 14) ) + ( PI if mouseVectorLeft.x + 14 >= 0 else 0 )
		
		if(distanceToMouseLeft >= maxLengthLeft):
		
			$Sprites/LeftBicept.rotation = angleToLeft
			$Sprites/LeftForearm.rotation = $Sprites/LeftBicept.rotation
			
			$Sprites/LeftBicept.scale = Vector2.ONE
			$Sprites/LeftForearm.position = Vector2(0,-boneLengthLeft)
			
		else:
			
			scaleValueLeft = ( boneLengthLeft / 2.3 ) * pow(1.0162, distanceToMouseLeft) 
			$Sprites/LeftBicept.rotation = asin( ( distanceToMouseLeft / 2 ) / scaleValueLeft ) + angleToLeft - PI/2 ## Shoulder
			$Sprites/LeftForearm.rotation = $Sprites/LeftBicept.rotation + acos( ( distanceToMouseLeft / 2 ) / scaleValueLeft ) * 2 ## Elbow
			
			## Change size of thing
			$Sprites/LeftBicept.scale.x = scaleValueLeft / boneLengthLeft
			
			## Eccential:
			lastMouseVectorLeft = mouseVectorLeft
		
	if(lastMouseVectorRight != mouseVectorRight):
		
		var maxLengthRight = 26 * 2
		var boneLengthRight = 26 ## Base bone length for left arm
		var scaleValueRight = boneLengthRight ## The calculated scale value to use in calculations
		
		var distanceToMouseRight = $Sprites/RightBicept.position.distance_to((mouseVectorRight))
		var angleToRight = atan( ( mouseVectorRight.y) / ( mouseVectorRight.x - 14) ) + ( PI if mouseVectorRight.x - 14 >= 0 else 0 )
		
		if(distanceToMouseRight >= maxLengthRight):
		
			$Sprites/RightBicept.rotation = angleToRight + PI
			$Sprites/RightForearm.rotation = $Sprites/RightBicept.rotation
			
			$Sprites/RightBicept.scale = Vector2.ONE
			$Sprites/RightForearm.position = Vector2(0,-boneLengthRight)
			
		else:
			
			scaleValueRight = ( boneLengthRight / 2.3 ) * pow(1.0162, distanceToMouseRight) 
			$Sprites/RightBicept.rotation = -asin( ( distanceToMouseRight / 2 ) / scaleValueRight ) + angleToRight - PI/2 ## Shoulder
			$Sprites/RightForearm.rotation = $Sprites/RightBicept.rotation + -acos( ( distanceToMouseRight / 2 ) / scaleValueRight ) * 2 ## Elbow
			
			## Change size of thing
			$Sprites/RightBicept.scale.x = scaleValueRight / boneLengthRight
		
		## Eccential:
		lastMouseVectorRight = mouseVectorRight
		

func swayAndDrag():
	
	## Sway
	pass
	
	
	## Drag
	pass
	
	
	## move and slide
	$Weapon/WeaponSway.position = (collectiveDrag + Vector2(sway, 0))
	if(gunPosLockLeft):
		$Sprites/LHandOffset.position = (collectiveDrag + Vector2(sway, 0))
	if(gunPosLockRight):
		$Sprites/RHandOffset.position = (collectiveDrag + Vector2(sway, 0))

## Animation Variables
enum {IDLE, FIRE, RELOAD, CHAMBER, CRACK, SWAY, FREE, DEBUGFREE}
## Idle - stays in weapon rest position
## Fire - when the weapon is firing, needs to account for recoil
## Reload - weapon being moved around and rotated during reload
## Chamber - Weapon being mostly stationary besides the chamber bits
## Crack - Weapon can be rotated and manipulated completly due to needs to scale and such
## Sway - weapon swaying while moving
## FREE - allows for free movement of weapon in acordance of hand locks 

@export var gunPosLockLeft := true ## If the gun position will be locked to the left hand
@export var gunPosLockRight := true ## If the gun position will be locked to the right hand

var currentLockPosition: Vector2 ## This + hand vector for final position and such
var offsetOfOffset: Vector2 ## This is used for changing offset in accordance of easy rotation

var animation = IDLE

func change_animation(anim: int):
	
	var new_anim = Animation.new()
	
	new_anim.add_track(Animation.TYPE_VALUE)
	$AnimationPlayer.add_animation('anim_name', new_anim)
	
	ResourceSaver.save(new_anim,'res://anim.tres')
