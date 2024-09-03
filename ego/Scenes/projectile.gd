extends CharacterBody2D

@export var SPEED = 1200

var dir : float
var spawnPos : Vector2
var spawnRot : float
var offsetMain : int
var offsetSecondary : int = 0

func _ready():
	global_position = spawnPos + Vector2(offsetMain,offsetSecondary).rotated(dir)
	global_rotation = spawnRot

func _physics_process(delta):
	velocity = Vector2(SPEED,0).rotated(dir)
	move_and_slide()

func _on_lifespan_timeout():
	queue_free()

func _on_hit_body_entered(body):
	queue_free()
