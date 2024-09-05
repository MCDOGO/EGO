extends Weapon_Parent

class_name Heavy_Weapon

#@export_file("*.png") var sprite
@export var gun_or_melee: bool = true ## gun: true, melee: false
@export_enum("One Handed:0", "Akimbo:1", "Two Handed:2", "Melee:4") var weapon_type: int ## For Animations
@export var charge_weapon: bool

@export var max_ammo: int
@export var max_reserves: int

@export_group("Gun")
@export_enum("FULL_AUTO:0", "SEMI_AUTO:1", "BURST:2", "SINGLE:4", "SHOTGUN:8") var fire_mode: int ## Just convenient
@export var fire_rate: float ## Time interval between gun shot
@export var magizine: bool ## Magazine: true, By Shell: false
@export var reload_speed: float ## Time for reload to happen

@export var recoil_severity: int ## TBD

@export var projectile_speed: int = 1200
@export var projectile_speed_falloff: int = 0 ## Probably just keep at 0 for now
@export var max_distance: float ## In time

@export var y_offset: int = 20 ## How far to offset the weapon so the projectiles come out of the tip of the gun

@export var explossive := false

@export_subgroup("Shotgun")
@export var pellet_count: int
@export var spread: int ## In degrees

@export_subgroup("Akimbo")
@export var x_offset: int = 0

@export_subgroup("Explossive")
var explossive_damage: int
var explossive_radius: int 
var explossive_duration: float ## Time
var explossive_smoke: bool = false

@export_group("Melee")
@export var single_handed: bool ## For animations

@export var swing_or_stab: bool ## Swing: true, Stab: false
@export var speed: float
@export var recovery: float

@export_subgroup("Swing")
@export var radius: int
@export var distance: int

@export_subgroup("Stab")
@export var attack_length: int
@export var attack_width: int
