extends Node

## Conditions: burning(fire related), stunned(flash bangs or explossives), zapped, poisoned
##    - Burning : damage over time, enemies lose % of armor
##    - Stunned : temporarily can't attack (Any enemy staggered is also considered "stunned")
##    - Zapped : damages enemies around for a fraction of the damage on taking damage
##    - Poisoned : damage over time, enemies slowed

## Check for if in smoke, if affected by a condition or two, what damaged the enemy (weapon type), and who damaged the enemy\
##                                                                 [Burning:1, Stunned:2, Zapped:4, Poisoned:8]
signal enemy_damaged(player: int, inSmoke: bool, weapon: Resource, conditions: int)
signal enemy_killed(player: int, inSmoke: bool, weapon: Resource, conditions: int)

signal player_reloading(time: float)
signal player_reload_cancel()
