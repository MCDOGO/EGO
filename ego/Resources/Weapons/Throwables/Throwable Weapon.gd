extends Weapon_Parent

class_name Throwable_Weapon

#@export_file("*.png") var sprite

@export var max_throwables: int

@export_enum("Explossive:0","Smoke:1","Trap:2") var type: int

@export var radius: int ##  The radius of the effect
@export var duration: int ## Duration of affect staing around (if set to 0, it will just be the initial explossion)
@export var detonation_delay: int = 0

## How status and damage work after the throwable triggered
@export_group("Post Status")
@export var post_status_chance: int
## Status damage works differently per damage type
	## - Burning: Damage per damage tick
	## - Stunned: Ammount of poise damage to do before stunned
	## - Zapped: Damage tranfer % to nearby enemies
	## - Poisoned: Armor reduction during duration
@export var post_status_damage: int 

@export_group("Trap Only")
@export var trap_radius: int = 0
