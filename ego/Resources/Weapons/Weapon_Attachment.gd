extends Resource

class_name Weapon_Attachment

@export_file("*.png") var sprite
@export var offset: Vector2
@export_range(0,360) var rotation: int ## Degrees
@export var name: String ## Check script for potential names
""" "load" for the chamberer, 
"top" for either the top part of a gun that moves, or the upper part of a gun that cracks, 
"crack" for the part that is revealed by a crach, 
"chmb" for the moving bit of the chamber
"""

@export var isStatic := true ## If the attachment can move
@export var canScale := false ## If the attachment can be scaled

@export var z_index = 0
