extends Node

@export var LeftHandRotLock: bool = false
@export var RightHandRotLock: bool = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if(!LeftHandRotLock):
		$LeftHand.rotation = $LeftMark.rotation + $LeftForearm.rotation
	if(!RightHandRotLock):
		$RightHand.rotation = $RightMark.rotation + $RightForearm.rotation
	#if(Input.is_action_just_pressed("Throwable")): ## E
	#	RightHandRotLock = !RightHandRotLock
	#if(Input.is_action_just_pressed("Swap Gun")): ## Q
	#	LeftHandRotLock = !LeftHandRotLock
	if(Input.is_action_just_pressed("Dash")):
		$"../AnimationPlayer".play("meleeWeaponHold")
		$"../AnimationPlayer".get_animation_library("meleeWeaponHold")
