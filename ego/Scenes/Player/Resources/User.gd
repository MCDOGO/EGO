extends Resource

class_name User

## Base stats
@export var max_health: int = 100
@export var speed: int = 300


## Weaponry
@export var primary_weapon: Primary_Weapon
@export var melee_weapon: Melee_Weapon
@export var heavy_weapon: Heavy_Weapon
@export var throwable_weapon: Throwable_Weapon

## Other equiped items
#@export var gloves: Equipable
#@export var shoes: Equipable
#@export var armor: Equipable
