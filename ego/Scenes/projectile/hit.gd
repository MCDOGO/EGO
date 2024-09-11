extends Area2D

## Variables
var damage: int = 0
var status_afflicted: int = 0
var status_damage: int = 0
var is_explode = false
var playerObj: CharacterBody2D

var parent: CharacterBody2D
const is_projectile = true


func _ready():
	parent = get_parent()
	playerObj = parent.playerObj
	damage = parent.damage
	status_afflicted = parent.status_afflicted
	status_damage = parent.status_damage

func get_weapon():
	return parent.weapon

func kill(pos: Vector2):
	get_parent().queue_free()
