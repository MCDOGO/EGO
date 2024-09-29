extends Node2D

@export var weapon: Weapon_Parent
@export var attachments: Array[int]

func _ready() -> void:
	pass # Replace with function body.

func set_up():
	if(!weapon.sprite == $"Gun Sprite".texture):
		$"Gun Sprite".texture = weapon.sprite
		for child: Sprite2D in $Attachments.get_children():
			child.texture
		if(weapon is Primary_Weapon || (weapon is Heavy_Weapon && weapon.gun_or_melee)):
			$Attachments/Mag.texture = Global.get_attachment_sprite(attachments[0])
			$Attachments/Mag.offset = weapon.magazine_offset
			$Attachments/Sight.texture = Global.get_attachment_sprite(attachments[1])
			$Attachments/Sight.offset = weapon.sight_offset
			$Attachments/Muzzle.texture = Global.get_attachment_sprite(attachments[2])
			$Attachments/Muzzle.offset = weapon.muzzle_offset
			$Attachments/Butt.texture = Global.get_attachment_sprite(attachments[3])
			$Attachments/Butt.offset = weapon.butt_offset
			if(weapon.show_projectile):
				$Attachments/Ammunition.texture = Global.get_attachment_sprite(attachments[4])
				$Attachments/Ammunition.offset = weapon.ammunition_offset

func remove_mag():
	$Attachments/Mag.texture = null

func add_mag_back():
	$Attachments/Mag.texture = Global.get_attachment_sprite(attachments[0])

func remove_projectile():
	$Attachments/Ammunition.texture = null

func add_projectile_back():
	$Attachments/Ammunition.texture = Global.get_attachment_sprite(attachments[4])
