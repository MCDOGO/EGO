extends Resource

class_name Enemy_Behavior

##   Aggression:
## The risk in which the enenmy is willing to take to accomplish a task high 
## aggression might mean they will ignore taking damage to pursue their objective.
## The lower the aggression, the less is needed to make the enemy abandon its
## Objective and take cover
## When passing max aggression, enemy will panic, and fight irrationally
##   Hazard:
## What the enemy might try and avoid when pathfinding


@export_range(0,100) var min_pathfind_player_aggression: int = 50 ## When the enemy will try t seek cover while still attempting objective
@export_range(0,100) var max_pathfind_player_aggression: int  = 90 ## Panic threshhold
@export_range(1,5) var panic_severity: int = 3 ## How the enemy will react to passing max_aggression
## Panic 1 - Will calmly seek safety while abandoning objective
## Panic 2 - Will completly abandon objective to seek safety
## Panic 3 - Will become somewhat unpredictable in a chaotic panic
## Panic 4 - Will become very unpredictable and indecisive in chaotic panic
## Panic 5 - Will act completly irrational when paniced

@export_group("Aggression Values")
## Will have two second cooldown for 'being_shot_at' and/or 'taking_damage' before aggression is removed
@export_range(0,100) var los_player: int = 5 ## Stacks per player (los = line of sight)
@export_range(0,100) var los_high_danger_player: int = 10 ## Stacks per player
@export_range(0,100) var being_shot_at: int = 30 ## Will not consider if taking damage, not per source
@export_range(0,100) var taking_damage: int = 50 ## Adds per unique sorce of damage (Player or area affect)
@export_range(0,100) var in_smoke: int = 20 ## Will run out of smoke if aggression met
## Condition Based
@export_range(0,100) var burning: int = 100 ## Being on fire will cause an enemy to panic
@export_range(0,100) var on_zapped: int = 10 ## Added to 'taking_damage'
@export_range(0,100) var poisoned: int = 10 ## Not added to 'taking_damage'
## Grenade
@export_range(0,100) var in_grenade_radius: int = 50
@export_range(0,100) var hazard_max: int = 50

@export_group("Hazard Values")

@export_range(0,10) var grenade_range: int = 7 ## Does not stack
@export_range(0,10) var grenade_effect: int = 5 ## Does not stack
