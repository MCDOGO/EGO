extends CharacterBody2D

## Navigation
@onready var nav_agent := $NavigationAgent2D

## Target Value
var targetVector := Vector2.ZERO
var targetPlayerID := 0
var targetPlayers: Array[Node2D]
var targetPlayerIDs: Array[int]

## Local Variables
	## Exported variables
@export var speed := 100
@export var health := 30
@export var armor := 0
@export var armorSpeed : int = 80
var hasArmor = false

@export_group("Weaponry")
@export var weapon : Weapon_Parent

@export var usesThrowables := false
@export var throwable : Throwable_Weapon
@export var throwables : int = 0

@export var start_angle : int = 0
	## Non Exported
var origin_vector: Vector2

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
var aggression = 0

var returnToOrigin := false
var hasLineOfSight := false

@export_group("Behavioral")
@export var behavior: Enemy_Behavior
@export var signal_group : int = 0 ## Used for enemy spawns and actions
@export_enum("Idle:0","Patrol:1","Ambush:2") var movenment_behavior : int = 0
@export var patrol_when_alert : bool = false ## Enemy will follow a patrol path when alert
@export var patrol_path : Array[Vector2i]
var patroll_index : int = 0
@export var stop_at_end_of_patrol := false
@export var patrol_speed : int = 50
@export var alert := false
var chasing := false

## Weapon
var min_range : int
var desired_range : int
var max_range : int
var melee_dash_range : int

func _ready() -> void:
	
	origin_vector = global_position
	$Rotates.rotation += deg_to_rad(start_angle)
	
	## Sets the reaction speed
	if(!alert):
		match(movenment_behavior):
			0: 
				$"Timers/Reaction Timer".wait_time = behavior.reaction_speed_idle
			1:
				$"Timers/Reaction Timer".wait_time = behavior.reaction_speed_patrolling
			2:
				$"Timers/Reaction Timer".wait_time = behavior.reaction_speed_ready
	else:
		if(movenment_behavior == 2):
			$"Timers/Reaction Timer".wait_time = behavior.reaction_speed_ready
		else:
			$"Timers/Reaction Timer".wait_time = behavior.reaction_speed_alert
	
	## Sets up weaponry and other behavioral variables
	if(weapon is Weapon_Gun):
		min_range = weapon.min_distance_tp
		desired_range = weapon.comfortable_distance_tp
		max_range = weapon.max_distance_tp
	else:
		pass


var previousCollider
func _physics_process(_delta):
	
	#$"Line Of Sight".force_raycast_update()
	hasLineOfSight = false
	
	## Simply sets if line of sight is true, and will later run priority behavior
	var hasPlayerInArea = false
	for player in $Rotates/Site.get_overlapping_bodies():
		if(player.playerSimpleID == targetPlayerID):
			hasPlayerInArea = true
			## Update later to add priority
			$"Line Of Sight".target_position = to_local(player.global_position)
			$"Line Of Sight".force_raycast_update()
			hasLineOfSight = !$"Line Of Sight".is_colliding()
			if(hasLineOfSight):
				targetVector = player.global_position
	## Starts the pathfinding stuff
	if(!chasing && hasLineOfSight):
		$Timer.start()
		chasing = true
		$"Timers/Reaction Timer".start()
		## If enemy hasn't been alert before
		if(!alert):
			alert = true
			$"Timers/Reaction Timer".wait_time = behavior.reaction_speed_alert
	if(!hasPlayerInArea):
		$"Line Of Sight".target_position = Vector2.ONE
	
	previousCollider = $"Line Of Sight".get_collider()
	
	## Behavior
	
	## For pathfinding
	var dir = to_local(nav_agent.get_next_path_position()).normalized()
	
	## Determins movement
	if(chasing):
		if(!nav_agent.is_target_reached() && $"Timers/Reaction Timer".is_stopped()):
			velocity = (dir * speed) #.rotated(PI/2)
		else:
			velocity = Vector2.ZERO
	elif(returnToOrigin):
		velocity = (dir * speed)
	
	## Determins rotation during movement
	if(chasing):
		$Rotates.rotation = get_angle_to(targetVector)
	elif(returnToOrigin):
		$Rotates.rotation = get_angle_to(nav_agent.get_next_path_position())
	
	## Aplies movenment
	move_and_slide()


## This creates the patht to the location
func makepath():
	nav_agent.target_position = targetVector


## Timer that draws a new pathfinding path every 0.2 seconds
var previousVector := Vector2.ZERO
func _on_timer_timeout() -> void:
	## Logic only for los on player
	if(targetVector != previousVector):
		makepath()
	previousVector = targetVector


## A method used to take damage (To be worked on)
func damage(dmg: int):
	health -= dmg
	if(health <= 0):
		#SignalBus.enemy_killed.emit()
		queue_free()


## When a projectile enters the enemies hitbox
func _on_hurt_box_area_entered(area: Area2D):
	if(true): ## Think about current target before turning to look at New target
		$Rotates.look_at(area.playerObj.global_position)
	if(targetPlayerIDs.has(area.playerObj.playerSimpleID)):
		targetPlayerID = area.playerObj.playerSimpleID
	if(area.is_explode):
		if($"Timers/Area Damage Tick".is_stopped()):
			damage(area.explosive_damage) ## Misspelled 'explosive'
			$"Timers/Area Damage Tick".start()
	else:
		damage(area.damage)
	SignalBus.enemy_damaged.emit(0, false, area.get_weapon(), 0)
	if(area.is_projectile && !area.is_explode):
		area.kill(global_position)


## Used when taking damage from hazard areas
func _on_hazard_box_body_entered(): 
	## Pathfind out of hazard area (In an aggressive or retreating way)
	pass


## For when the enemy has lost the player, and finished looking around
func _on_checking_timer_timeout() -> void:
	chasing = false
	returnToOrigin = true
	targetVector = origin_vector
	makepath()
	$Timer.stop()


## For when the enemy has finished reacting
func _on_reaction_timer_timeout() -> void:
	$"Timers/Reaction Timer".wait_time = behavior.reaction_speed_alert


## Used for when target is reached and no line of sight
func _on_navigation_agent_2d_target_reached() -> void:
	if(!hasLineOfSight):
		if(chasing):
			$"Timers/Checking Timer".start()
		elif(returnToOrigin):
			returnToOrigin = false
			$Rotates.rotation = deg_to_rad(start_angle)
			velocity = Vector2.ZERO
