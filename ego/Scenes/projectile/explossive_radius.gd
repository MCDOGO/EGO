extends Area2D

var damage: int = 0
var status_afflicted: int = 0
var status_damage: int = 0
var is_explode = true

var parent: CharacterBody2D
const is_projectile = true

func _ready():
	parent = get_parent().get_parent()
	damage = parent.damage
	status_afflicted = parent.status_afflicted
	status_damage = parent.status_damage

func get_weapon():
	return parent.weapon
