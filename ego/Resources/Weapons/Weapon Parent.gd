extends Resource

class_name Weapon_Parent


@export_group("Weapon Parent")

@export var name: String
@export var ID: int
@export_file("*.png") var sprite
@export var sprite_offset: Vector2i
@export var muzzle_position: Vector2i


@export_subgroup("Damage and Critical")

@export var damage := 5
@export var crit_chance := 10
@export var crit_multiplier := 2.0
@export var armor_penetration_chance := 0
@export var armor_penetration_amount := 0
@export var silent := false ## Sound attracts enemies


@export_subgroup("Status")

@export var status_chance: int
@export var status: int ## [Burning:1, Stunned:2, Zapped:4, Poisoned:8]
## Status damage works differently per damage type
	## - Burning: Damage per damage tick
	## - Stunned: Ammount of poise damage to do before stunned
	## - Zapped: Damage tranfer % to nearby enemies
	## - Poisoned: Armor reduction during duration
@export var status_damage: int 
@export var status_duration: float


@export_subgroup("Enemy Values")
## tp = to player
@export var min_distance_tp : int = 400 ## Distance needed to use weapons
@export var comfortable_distance_tp : int = 350 ## Distance until the enemy will comfortably stay still and fire (maybe strafe if desired)
@export var max_distance_tp : int = 300 ## Distance until the enemy will want to leave
@export var melee_rush_tp : int = 100 ## Distance melee enemies will need to be to melee
