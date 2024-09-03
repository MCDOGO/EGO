extends CharacterBody2D

@export var SPEED = 1200
var weapon: Weapon_Parent = null

var dir : float
var spawnPos : Vector2
var spawnRot : float
var offsetMain : int
var offsetSecondary : int = 0
var damage: int
var status_afflicted: int
var status_damage: int

func _ready():
	global_position = spawnPos + Vector2(offsetMain,offsetSecondary).rotated(dir)
	global_rotation = spawnRot

func _physics_process(_delta):
	velocity = Vector2(SPEED,0).rotated(dir)
	move_and_slide()

## Signals
func _on_lifespan_timeout():
	queue_free()

func _on_hit_body_entered(_body):
	queue_free()
