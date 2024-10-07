extends Resource

class_name Attribute

@export_enum("Damage:0", "Critical:1", "Status:2", "Armor_Penetration:3", "Burn:4", 
"Stun:5", "Zap:6", "Poison:7", "Explossion:8", "Speed:9") var effect: int = 0
@export_enum("Damage:0", "Chance:1", "Area:2", "Duration:3") var effect_chance: int = 0
@export var effect_scale: float = 1.0
@export var add_or_multiply: bool = true

## Damage - 0
## Critical - 0, 1
## Status - 0, 1, 3
## Armor Penetration - 0, 1
## Burn - 0, 1, 3
## Stun - 1, 3
## Zap - 0, 1, 2
## Poison - 0, 1, 3
## Explossion - 0, 2, 3
## Speed - 0

@export_group("Exceptions")
@export_flags("Primary:1", "Heavy:2", "Melee:4", "Throwable:8") var target : int
@export_flags("No_Armor:1", "Armored:2", "No_Status:4", "Status:8", "No_Burn:16", 
"No_Stun:32", "No_Zap:64", "No_Poison:128", "Burn:256", "Stun:512", "Zap:1024", 
"Poison:2048", "is_explossive:4096") var exceptions : int
