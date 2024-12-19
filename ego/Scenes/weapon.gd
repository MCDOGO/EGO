extends Node2D

@export var weapon: Weapon_Parent
var attachments: Array[Weapon_Attachment]

var thing : Weapon_Gun

var sorted_nodes : Array[Sprite2D]


func set_up():
	
	changeOffset(gunPosLockRight, true)
	
	
	for node in $WeaponSway/WeaponOffset.get_children():
		if(!(node.name == $WeaponSway/WeaponOffset/Attachments.name || node.name == $WeaponSway/WeaponOffset/Weapon.name)):
			remove_child(node)
	
	$WeaponSway/WeaponOffset/Weapon.texture = load(weapon.sprite)
	$WeaponSway/WeaponOffset/Weapon.offset = weapon.sprite_offset
	
	attachments = weapon.Attachments
	
	if(weapon is Weapon_Gun):
		for attachment:Weapon_Attachment in attachments:
			var newSprite = Sprite2D.new()
			newSprite.texture = load(attachment.sprite)
			newSprite.position = attachment.offset
			newSprite.rotation = attachment.rotation
			newSprite.z_index = attachment.z_index
			
			if(attachment.name != ""):
				newSprite.name = attachment.name
			
			sorted_nodes.append(newSprite)
	
	## Fix at some point so I don't need this temporary fix (:
	sorted_nodes.sort_custom(
		# For descending order use > 0
		func(a: Sprite2D, b: Sprite2D): return a.z_index - b.z_index > 0
	)
	
	for node in sorted_nodes:
		if(node.z_index > 0):
			node.z_index = 0
			$WeaponSway/WeaponOffset.add_child(node)
		else:
			$WeaponSway/WeaponOffset/Attachments.add_sibling(node)
	
	#$ColorRect2.position = weapon.muzzle_position


@export var gunPosLockLeft := false ## If the gun position will be locked to the left hand
@export var gunPosLockRight := true ## If the gun position will be locked to the right hand

var offsetRotation: float


## hand: true for right, false for left
func changeOffset(hand: bool, lockOther: bool):
	

	if(hand):
		$WeaponSway/WeaponOffset.position = -(weapon.rightHandRest /2) ## Change from rest to variable offset
		$RightHand.update_position = false
		$RightHand.update_rotation = false
		
		if(lockOther):
			$LeftHand.update_position = true
			$LeftHand.update_rotation = false
			$LeftHand.position = (weapon.leftHandRest /2) - (weapon.rightHandRest /2) ## Change from rest to variable offset
		
	else:
		$WeaponSway/WeaponOffset.position = -(weapon.leftHandRest /2) ## Change from rest to variable offset
		$LeftHand.update_position = false
		$LeftHand.update_rotation = false
		
		if(lockOther):
			$RightHand.update_position = true
			$RightHand.update_rotation = false
			$RightHand.position = (weapon.rightHandRest /2) - (weapon.leftHandRest /2) ## Change from rest to variable offset
