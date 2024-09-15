extends Weapon_Parent
class_name Weapon_Gun

@export_group("Effects")
@export_file("*.png") var projectile ## Sprite for projectile
@export_file("*.png") var casing ## Sprite for casing
@export var projectileHitBoxSize: Vector2i = Vector2i(12,6)
@export var ejectCasingLeft: bool = false ## Direction that casings will be ejected
@export_range(0,100) var screenShake: int = 20 ## Screen shake added per shot fired
@export_range(0,100) var screenShakeMax: int = 60 ## Max screen shake before it stops adding over

@export_range(0,100) var smokeSeverity: int = 10
@export_range(0,100) var sparkSeverity: int = 10

# @export_file() var fireingSound
# @export_file() var reloadSound
# @export_file() var chamberSound ## Only for weapons that are single_fire
