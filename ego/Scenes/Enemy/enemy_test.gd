extends CharacterBody2D

## Target Value
var targetVector := Vector2.ZERO
var targetPlayerID := 0
var targetPlayers: Array[Node2D]
var targetPlayerIDs: Array[int]

## Local Variables
	## Exported variables
@export var speed = 100
@export var health = 30
@export var weapon : Weapon_Parent
	## Non Exported
var Origin: Vector2

## Statuses
var burnedAmmount: int
var burned: bool
@onready var burnedTimer = $"Timers/Burned Timer"
var stunnedAmmount: int
var stunned: bool
@onready var stunnedTimer = $"Timers/Stunned Timer"
var zappedAmmount: int
var zapped: bool
var poisonedAmmount: int
var poisoned: bool
@onready var poisonedTimer = $"Timers/Poisoned Ammount"

## Behavior
@onready var lineOfSight = $"Check For Player"
var aggression = 0

@export var behavior: Enemy_Behavior
var returnToOrigin := false
var hasLineOfSight := true

## Navigation
@onready var nav_agent := $NavigationAgent2D


func _ready() -> void:
	Origin = global_position
	$Timer.start()


var previousAngle := 0
var tempAngle := 0

func _physics_process(delta):
	
	## For pathfinding
	var dir = to_local(nav_agent.get_next_path_position()).normalized()
	## Behavior
	$"Check For Player/CollisionShape2D".shape.b = to_local(targetVector) ## To check for line of sight
	if(!nav_agent.is_target_reached()):
		velocity = (dir * speed) #.rotated(PI/2)
	else:
		velocity = Vector2.ZERO
	
	## This checks if line of sight is valid
	#if(lineOfSight.has_overlapping_bodies()):
	#	print("a")
	
	var currentAngle = $Rotates.rotation+PI
	var angleToPlayer = get_angle_to(targetVector)+PI
	
	if(hasLineOfSight):
		$Rotates.rotation = get_angle_to(targetVector)
	
	## Aplies movenment
	move_and_slide()


## This creates the patht to the location
func makepath():
	nav_agent.target_position = targetVector


func _on_timer_timeout() -> void:
	## Logic only for los on player
	var currentAngle = $Rotates.rotation+PI
	var angleToPlayer = get_angle_to(targetVector)+PI
	makepath()


func damage(dmg: int):
	health -= dmg
	if(health <= 0):
		queue_free()


func set_player_vector(playerPos: Vector2):
	targetVector = playerPos


func _on_hurt_box_area_entered(area):
	$Rotates.look_at(area.playerObj.global_position)
	if(area.is_explode):
		if($"Timers/Area Damage Tick".is_stopped()):
			damage(area.explossive_damage)
			$"Timers/Area Damage Tick".start()
	else:
		damage(area.damage)
	SignalBus.enemy_damaged.emit(0, false, area.get_weapon(), 0)
	if(area.is_projectile && !area.is_explode):
		area.kill(global_position)


## This will check if the line to the targetted player is blocked by an object
func _on_check_for_player_body_entered(body: Node2D) -> void:
	hasLineOfSight = false
	$Timer.stop()


func on_check_for_player_body_exited(body: Node2D) -> void:
	if(targetPlayerIDs.has(targetPlayerID)):
		hasLineOfSight = true
		if(is_instance_valid(get_parent())):
			$Timer.start()

## If player enters the POV of the enemy
func _on_site_area_entered(area: Area2D) -> void:
	if(area.get_parent() is CharacterBody2D):
		targetPlayerIDs.append(area.get_parent().playerSimpleID)
		on_check_for_player_body_exited(area)

## If player leaves the POV of the enemy
func _on_site_area_exited(area: Area2D) -> void:
	if(area.get_parent() is CharacterBody2D):
		targetPlayerIDs.erase(area.get_parent().playerSimpleID)
