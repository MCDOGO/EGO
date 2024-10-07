extends Weapon_Parent
class_name Weapon_Gun


@export var charge_weapon: bool = false
@export var multi_projectile: bool = false
@export var burst: bool = false
@export var explossive: bool = false
@export var automatic: bool = false
@export var heavy_weapon: bool = false

@export var max_ammo: int

@export_enum("One Handed:0", "Akimbo:1", "Two Handed:2") var weapon_type: int ## For Animations

@export_enum("FULL_AUTO:0", "SEMI_AUTO:1", "BURST:2", "SINGLE:4", "SHOTGUN:8", "CHARGED:16") var fire_mode: int ## Just convenient
@export var fire_rate: float ## Time interval between gun shot
@export var magizine: bool = true ## Magazine: true, By Shell: false
@export var reload_speed: float ## Time for reload to happen
@export var laser: bool = false ## Projectile will draw a line and die (can expload at end point)

@export var recoil_severity: int ## knock back on fire
@export var recoil_movenmnet_scale: int

@export var projectile_speed: int = 1200
@export var projectile_speed_falloff: int = 0 ## How quickly projectiles should slow down
@export var max_distance: int = -1 ## In distance (negative for no limit but time)

@export var y_offset: int = 20 ## How far to offset the weapon so the projectiles come out of the tip of the gun


@export_group("Weapon Type Based")

@export_subgroup("Akimbo")
@export var x_offset: int = 0

@export_subgroup("Explossive")
@export var explossive_damage: int
@export var explossive_radius: int 
@export var explossive_duration: float ## Time
@export var explossive_smoke: bool = false

@export_subgroup("Charged")
@export var valid_or_release: bool = false ## Weather you need to wait for charge, or release on charge
@export var valid_timer: float ## Time until you can release
@export var var_max_timer: float ## Time until max damage, or forced release
@export var full_charge_damage: float = 1.0 ## Multiplier
@export var full_charge_crit_chnc: float = 1.0 ## Multiplier
@export var full_charge_crit_dmg: float = 1.0 ## Multiplier

@export_subgroup("Multi Shot (Burst and Shotgun)")
@export var projectile_ammount: int = 0
@export var burst_spread: int = 10 ## in degrees
@export var time_between: float = 0.1 ## Set to 0 for no burst
@export var groups : int = 1 ## Groups of projectile Shots per burst

@export_subgroup("Heavy Weapon")
@export var max_reserves: int


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
