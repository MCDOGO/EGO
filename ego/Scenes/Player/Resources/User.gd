extends Resource

class_name User


## Base stats
@export var armor: Armor

## Weaponry
@export var primary_weapon: Weapon_Gun
@export var melee_weapon: Melee_Weapon
@export var heavy_weapon: Weapon_Gun
@export var throwable_weapon: Throwable_Weapon
@export var starting_throwables: int = 2
