extends Weapon_Parent

class_name Throwable_Weapon

#@export_file("*.png") var sprite

@export var max_throwables: int = 7
@export var starting_throwables: int = 2
@export var post_effect: bool = false
@export var trap: bool = false
@export var smoke: bool = false
## You have to throw anohter projectile after the first to detonate it
@export var manual_detonation: bool = false 

@export_enum("Explossive:0", "Smoke:1", "Trap:2") var type: int

@export var throw_strength: float = 1 ## Multiplier for throw distance strength
@export var radius: int ##  The radius of the effect
@export var detonation_delay: float = 0 ## 
@export var duration: float ## Duration of affect staying around (if set to 0, it will just be the initial explossion)

## How status and damage work after the throwable triggered
@export_group("Post Effect")
@export var post_status_chance: int
## Status damage works differently per damage type
	## - Burning: Damage per damage tick
	## - Stunned: Ammount of poise damage to do before stunned
	## - Zapped: Damage tranfer % to nearby enemies
	## - Poisoned: Armor reduction during duration
@export var post_status_damage: int 
@export var post_crit_chance: int
@export var post_crit_damage: int

@export_group("Trap Only")
@export var trap_radius: int = 0
