extends Resource

class_name Weapon_Parent

@export_group("Weapon Parent")

@export var name: String
@export_file("*.png") var sprite

@export_group("Damage and Critical")
@export var damage: int
@export var crit_chance: int
@export var crit_multiplier: float

@export_group("Status")
@export var status_chance: int
@export var status: int ## [Burning:1, Stunned:2, Zapped:4, Poisoned:8]
## Status damage works differently per damage type
	## - Burning: Damage per damage tick
	## - Stunned: Ammount of poise damage to do before stunned
	## - Zapped: Damage tranfer % to nearby enemies
	## - Poisoned: Armor reduction during duration
@export var status_damage: int 
@export var status_duration: float
