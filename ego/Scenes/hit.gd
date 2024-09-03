extends Area2D

## Variables
var damage: int = 0
var status_afflicted: int = 0
var status_damage: int = 0

func _ready():
	damage = get_parent().damage
	status_afflicted = get_parent().status_afflicted
	status_damage = get_parent().status_damage

func get_weapon():
	return get_parent().weapon

func kill(pos: Vector2):
	get_parent().queue_free()
