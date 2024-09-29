extends Weapon_Parent
class_name Weapon_Gun


@export_group("Visuals")
@export_file("*.png") var projectile ## Sprite for projectile
@export var projectile_hit_box_size: Vector2i = Vector2i(12,6)
@export_file("*.png") var casing_or_mag ## Sprite for casing or magazine
@export var eject_casing_left: bool = false ## Direction that casings will be ejected

## Effects Related
@export_range(0,100) var screen_shake_per: int = 20 ## Screen shake added per shot fired
@export_range(0,100) var screen_shake_max: int = 60 ## Max screen shake before it stops adding over
@export_range(0,100) var smoke_severity: int = 10
@export_range(0,100) var spark_severity: int = 10

#export_group("Sounds")
# @export_file() var fireingSound
# @export_file() var reloadSound
# @export_file() var chamberSound ## Only for weapons that are single_fire

@export_group("Attachments")
@export var magazines : Array[int] ## Holds attachment IDS
@export var magazine_offset: Vector2i
@export var sights : Array[int] ## Holds attachment IDS
@export var sight_offset: Vector2i
@export var muzzles : Array[int] ## Holds attachment IDS
@export var muzzle_offset: Vector2i
@export var butts : Array[int] ## Holds attachment IDS
@export var butt_offset: Vector2i
@export var show_projectile: bool = false
@export var munitions : Array[int] ## Holds attachment IDS
@export var ammunition_offset: Vector2i
