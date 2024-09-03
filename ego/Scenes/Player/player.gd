extends CharacterBody2D

## Constant/Final Variables
const ballin = true

## Internal Nodes
@onready var fireRateRefresh = $"Timers/Fire Rate Refresh"

## External Nodes and Scenes
@onready var main = get_tree().get_root().get_node(".")
@onready var projectile = load("res://Scenes/Projectile.tscn")

## Objects and Exports
var player

## Variables
var SPEED = 300.0

## Player Based Stats


func _ready():
	pass

func _physics_process(delta):
	## Movement
	var direction = Input.get_vector("Left", "Right", "Up", "Down")
	direction.normalized()
	velocity = direction * SPEED
	
	## Checks if you can fire main weapon
	if(Input.is_action_pressed("Fire") && fireRateRefresh.is_stopped()):
		shoot()
	
	## Makes you look at cursor
	look_at(get_global_mouse_position())
	
	## Applies movement
	move_and_slide()

## Handles creating projectiles
var offsetSwap = false

func shoot():
	## Standard Procedure
	var instance = projectile.instantiate()
	instance.dir = rotation
	instance.spawnPos = global_position
	instance.spawnRot = global_rotation
	offsetSwap = !offsetSwap
	
	## Based on weapon
	instance.offsetMain = 40
	instance.offsetSecondary = 5 * (1 if offsetSwap else -1)
	
	## Creating the projectile
	main.add_child.call_deferred(instance)
	fireRateRefresh.start()
