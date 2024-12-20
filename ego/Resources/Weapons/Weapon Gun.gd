extends Weapon_Parent
class_name Weapon_Gun


@export var charge_weapon: bool = false
@export var multi_projectile: bool = false ## Shotguns n stuff
@export var burst: bool = false ## Yippee
@export var explossive: bool = false
@export var automatic: bool = false ## Can be active with other options
@export var heavy_weapon: bool = false

@export var single_fire_option: bool = true ## Has an option to swap to single fire

@export var max_ammo: int ## Ammo in magazine

@export_enum("One Handed:0", "Akimbo:1", "Two Handed:2") var weapon_type: int ## For Animations

@export_enum("FULL_AUTO:0", "SEMI_AUTO:1", "BURST:2", "SINGLE:4", "SHOTGUN:8", "CHARGED:16") var fire_mode: int ## Just convenient
@export var fire_rate: float ## Time interval between gun shot

@export var magizine: bool = true ## Magazine: true, By Shell: false
@export var reload_speed: float ## Time for reload to happen

@export var chamber_bullet : bool = false ## If an anim needs to play to load the next shot
@export var chamber_speed : float

@export var laser: bool = false ## Projectile will draw a line and die (can expload at end point)
@export_range(0,1) var piercing : float = 0.0 ## The value it starts with when penetrating targets

@export_range(0,2) var recoil_severity: float = 0.05 ## knock back on fireing
@export_range(0,1) var recoil_movenmnet_scale: float = 0.01 ## How much movement will be affected by recoil

@export var projectile_speed: int = 1200
@export_range(0,1) var projectile_speed_falloff: float = 0.0001 ## How quickly projectiles should slow down
@export var max_distance: int = -1 ## In distance (negative for no limit but time)

@export_group("Weapon Type Based")

@export_subgroup("Akimbo")
@export var x_offset: int = 0

@export_subgroup("Explossive")
@export var explossive_damage: int
@export var explossive_radius: int 
@export var explossive_duration: float ## Time
@export var explossive_smoke: bool = false

@export_subgroup("Charged")
@export var ready_or_release: bool = false ## Weather you need to wait for charge, or release on charge (can't fire projectile sooner)
@export var ready_timer: float ## Time until you can release
@export var var_max_timer: float ## Time until max damage, or forced release (Can equal 0 for none)
@export var full_charge_damage: float = 1.0 ## Multiplier
@export var full_charge_crit_chnc: float = 1.0 ## Multiplier
@export var full_charge_crit_dmg: float = 1.0 ## Multiplier
@export var over_charge_timer : float ## For when it's charged for too long, or long enough
@export var over_charge_damage : float = 1.0 ## Multiplier


@export_subgroup("Multi Shot (Burst and Shotgun)")
@export var projectile_ammount: int = 0 ## ammount of projectiles
@export var burst_spread: int = 10 ## in degrees
@export var time_between: float = 0.1 ## Set to 0 for no burst
@export var groups : int = 1 ## Groups of projectile Shots per burst

@export_subgroup("Heavy Weapon")
@export var max_reserves: int ## Messure in magazines, or ammunition
@export var resserve_grant_pickup: int ## Resserves given back on heavy ammo pickup

@export_group("Visuals")
@export_color_no_alpha var projectile_color
@export_range(0,1) var color_lerp : float = 0.01
@export var projectile_fade_speed : float = 0.1

@export var projectile_hit_box_width: float = 6 ## The x will still be necisarry for lasers (Width of projectile)
@export_file("*.png") var casing ## Sprite for casing or magazine
@export var eject_casing_left: bool = false ## Direction that casings will be ejected
@export_file("*.png") var magazine_or_projectile ## Sprite for casing or magazine


## Effects Related
@export_range(0,2) var screen_shake_per: float = 0.2 ## Screen shake added per shot fired
@export_range(0,2) var screen_shake_max: float = 0.6 ## Max screen shake before it stops adding over
@export_range(0,2) var smoke_severity: float = 0.1
@export_range(0,2) var spark_severity: float = 0.1
@export_range(0,2) var flash_severity: float = 0.1 ## Flashes the color of the projectile

#export_group("Sounds")
# @export_file() var fireingSound
# @export_file() var reloadSound
# @export_file() var chamberSound ## Only for weapons that are single_fire

@export_group("Attachments")
@export var Attachments : Array[Weapon_Attachment]
