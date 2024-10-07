extends Resource

class_name Weapon_Attachment

@export_file("*.png") var sprite

@export var name : String
@export var ID : int
@export_enum("") var attachment_type: int

@export var effects : Array[Attribute]
