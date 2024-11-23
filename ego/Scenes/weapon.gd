extends Node2D

@export var weapon: Weapon_Parent
@export var attachments: Array[Weapon_Attachment]

var thing : Weapon_Gun

func _ready() -> void:
	set_up()

func set_up():
	$Weapon.texture = load(weapon.sprite)
	$Weapon.offset = weapon.sprite_offset
	
	attachments = weapon.Attachments
	print(attachments.size())
	
	if(weapon is Weapon_Gun):
		for attachment:Weapon_Attachment in attachments:
			print("Attachment")
			var newSprite = Sprite2D.new()
			newSprite.texture = load(attachment.sprite)
			newSprite.position = attachment.offset
			newSprite.rotation = attachment.rotation
			newSprite.z_index = attachment.z_index
			
			if(attachment.name != ""):
				newSprite.name = attachment.name
			
			$Attachments.add_child(newSprite)
