extends Weapon_Parent

class_name Primary_Weapon

#@export_file("*.png") var sprite
@export_enum("One Handed:0", "Akimbo:1", "Two Handed:2") var weapon_type: int ## For Animations

@export var max_ammo: int ## Maximum amount of ammo befor reload
@export_enum("FULL_AUTO:0", "SEMI_AUTO:1", "BURST:2", "SINGLE:4", "SHOTGUN:8") var fire_mode: int ## Just convenient
@export var fire_rate: float ## Time interval between gun shot
@export var magizine: bool ## Magazine: true, By Shell: false
@export var reload_speed: float ## Time for reload to happen

@export var recoil_severity: int ## TBD

@export var projectile_speed: int = 1200
@export var projectile_speed_falloff: int = 0 ## Probably just keep at 0 for now
@export var max_distance: float ## In time

@export var y_offset: int = 20 ## How far to offset the weapon so the projectiles come out of the tip of the gun

@export var explossive: bool = false

@export_group("Weapon Type Based")
@export_subgroup("Shotgun")
@export var pellet_count: int = 0
@export var spread: int = 0 ## In degrees

@export_subgroup("Akimbo")
@export var x_offset: int = 0

@export_subgroup("Explossive")
var explossive_damage: int
var explossive_radius: int 
var explossive_duration: float ## Time
var explossive_smoke: bool = false
