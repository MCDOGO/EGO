extends CharacterBody2D

var playerVector = Vector2.ZERO

@export var health = 100

var burned_ammount: int
var burned: bool

var stunned_ammount: int
var stunned: bool

var zapped_ammount: int
var zapped: bool

var poisoned_ammount: int
var poisoned: bool

func _physics_process(delta):
	
	look_at(playerVector)
	
	#move_and_slide()

func damage(dmg: int):
	health -= dmg
	if(health <= 0):
		queue_free()

func set_player_vector(playerPos: Vector2):
	playerVector = playerPos

func _on_hurt_box_area_entered(area):
	damage(area.damage)
	SignalBus.enemy_damaged.emit(0, false, area.get_weapon(), 0)
	area.kill(global_position)
