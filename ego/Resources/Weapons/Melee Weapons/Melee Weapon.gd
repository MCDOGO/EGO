extends Weapon_Parent

class_name Melee_Weapon

#@export_file("*.png") var sprite
@export var single_handed: bool ## For animations

@export var swing_or_stab: bool ## Swing: true, Stab: false
@export var speed: float
@export var recovery: float

@export_group("Swing")
@export var radius: int
@export var distance: int

@export_group("Stab")
@export var attack_length: int
@export var attack_width: int
