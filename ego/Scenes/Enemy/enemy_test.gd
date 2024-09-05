extends CharacterBody2D

## Target Value
var playerVector := Vector2.ZERO
var targetPlayerID := 0
var targetPlayer: Node2D

## Navigation
@onready var nav_agent := $NavigationAgent2D as NavigationAgent2D

## Local Variables
@export var speed = 100
@export var health = 30

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

var returnToOriging := false

func _ready() -> void:
	$Timer.start()


var previousAngle := 0
var tempAngle := 0

func _physics_process(delta):
	
	var dir = to_local(nav_agent.get_next_path_position()).normalized()
	if(returnToOriging || !nav_agent.is_target_reached()):
		velocity = (dir * speed) #.rotated(PI/2)
	else:
		velocity = Vector2.ZERO
	move_and_slide()
	$"Check For Player/CollisionShape2D".shape.b = to_local(playerVector)
	
	##if(previousAngle != )
	
	if(nav_agent.is_target_reached()):
		$Sprites.look_at(playerVector)
	else:
		if((get_angle_to(nav_agent.get_next_path_position())+PI)>PI):
			$Sprites.rotation = (lerp($Sprites.rotation,get_angle_to(nav_agent.get_next_path_position()),0.1))
		else:
			$Sprites.rotation = (lerp($Sprites.rotation,get_angle_to(nav_agent.get_next_path_position()),-0.1))
	
	print((get_angle_to(nav_agent.get_next_path_position())+PI))
	## Will be needed for later enemy behavior
	# nav_agent.distance_to_target()


func makepath():
	nav_agent.target_position = playerVector

func _on_timer_timeout() -> void:
	makepath()

func damage(dmg: int):
	health -= dmg
	if(health <= 0):
		queue_free()

func set_player_vector(playerPos: Vector2):
	playerVector = playerPos

func _on_hurt_box_area_entered(area):
	if(area.is_explode):
		if($"Timers/Area Damage Tick".is_stopped()):
			damage(area.explossive_damage)
	else:
		damage(area.damage)
	SignalBus.enemy_damaged.emit(0, false, area.get_weapon(), 0)
	if(area.is_projectile && !area.is_explode):
		area.kill(global_position)


func _on_check_for_player_body_entered(body: Node2D) -> void:
	$Timer.stop()


func _on_check_for_player_body_exited(body: Node2D) -> void:
	if(is_instance_valid(get_parent())):
		$Timer.start()
