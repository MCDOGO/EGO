extends Resource

class_name Armor

@export var ID : int
@export var name : String

@export var base_speed := 300
@export var base_health := 100
@export var armor_value := 100
@export var armor_damage_reduction := 0.1
@export var armor_speed_deduction := 0.9
@export var armor_regen := 10 ## Per second
@export var armor_regen_start := 5.0
@export var shield_gate_cooldown := 2.0
@export var armor_break_invincible := 1.0

@export_group("Effects")
@export var general_attributes : Array[Attribute]
@export var armor_attributes : Array[Attribute]
@export var no_armor_attributes : Array[Attribute]

@export_group("Base Stats")
@export var burn_resistance : float
@export var stun_resistance : float
@export var zap_resistance : float
@export var poison_resistance : float
