extends CharacterBody2D
class_name Player

## Constant/Final Variables
const ballin = true

## Internal Nodes
@onready var fireRateRefresh = $"Timers/Fire Rate Refresh"
@onready var reloadSpeed = $"Timers/Reload Speed"
@onready var swingingSpeed = $"Timers/Swinging Speed"

## External Nodes and Scenes
@onready var main = get_tree().get_root().get_node(".")
@onready var projectile = load("res://Scenes/projectile/Projectile.tscn")

## Objects and Exports
@export var player: User
@export var weaponOveride: Primary_Weapon

## Multiplayer Based
var playerSimpleID = 0 ## For simple checks to see if you are the proper user

## Variables
var priority := 0
var SPEED = 300.0 ## Shouldn't be changed after being set

## Player Based Stats
	## Base Stats
var VIT: int = 0 ## Vitality (Affects health and armor based traits)
var AGI: int = 0 ## Agility (Affects speed related traits)
var LUK: int = 0 ## Luck (Affects rng related traits)

	## Weapon related
var active_weapon: Weapon_Parent

var primary_weapon: Primary_Weapon
var MAXPRIMARYAMMO: int ## Shouldn't be changed after being set
var primaryAmmo: int

var melee_weapon: Melee_Weapon

var heavy_weapon: Heavy_Weapon
var MAXHEAVYAMMO: int ## Shouldn't be changed after being set
var heavyAmmo: int = 0
var MAXHEAVYAMMORESERVES: int
var heavyAmmoReserves: int = 0

var throwable_weapon: Throwable_Weapon
var MAXTHROWABLES: int ## Shouldn't be changed after being set
var throwables: int
var THROW_DISTANCE: int = 100 ## Will be changed by stats

	## Player statistics
var BASE_HEALTH: int ## Shouldn't be changed after being set
var health: int


func _ready():
	## Signals
	SignalBus.enemy_damaged.connect(enemy_hurt)
	reloadSpeed.timeout.connect(on_reload_speed_timeout)
	## Set Up
	set_up_player()


## Will set all variables to what they are ment to be
func set_up_player():
	if(weaponOveride != null):
		primary_weapon = weaponOveride
		
		MAXPRIMARYAMMO = primary_weapon.max_ammo
		primaryAmmo = MAXPRIMARYAMMO
		
		weapon_swap(weaponOveride)
	if(player != null):
		primary_weapon = player.primary_weapon
		melee_weapon = player.melee_weapon
		heavy_weapon = player.heavy_weapon
		throwable_weapon = player.throwable_weapon
		
		## Primary Weapon
		MAXPRIMARYAMMO = primary_weapon.max_ammo
		primaryAmmo = MAXPRIMARYAMMO
		
		## Melee Weapon
		
		
		## Heavy Weapon
		MAXHEAVYAMMO = heavy_weapon.max_ammo
		#heavyAmmo = player.starting_heavy_ammo
		MAXHEAVYAMMORESERVES = heavy_weapon.max_reserves
		
		## Throwable
		MAXTHROWABLES = throwable_weapon.max_ammo
		#throwables = player.starting_throwables
		
		## Player
		VIT = 0
		AGI = 0
		LUK = 0
		
	else:
		print("User Null")


func _physics_process(_delta):
	## Movement
	var direction = Input.get_vector("Left", "Right", "Up", "Down")
	direction.normalized()
	velocity = direction * SPEED
	
	## Checks if you can fire main weapon
	if(Input.is_action_pressed("Fire") && fireRateRefresh.is_stopped() && reloadSpeed.is_stopped()):
		if(weaponOveride == null):
			weapon_swap(active_weapon)
		attack(true)
		print(primaryAmmo)
	elif(Input.is_action_pressed("Melee")):
		pass
		#weapon_swap(Melee_Weapon)
		#attack(false)
	
	## Makes you look at cursor
	look_at(get_global_mouse_position())
	
	## Applies movement
	move_and_slide()


## Will handle what to do based on active weapon when attack buttons are pressed
func attack(shooting:bool):
	if(shooting):
		if(active_weapon is Primary_Weapon):
			if(primaryAmmo > 0):
				primaryAmmo -= 1
				fireRateRefresh.start()
				create_projectile()
			else:
				reload()
		else:
			if(heavyAmmo > 0):
				if(heavyAmmoReserves > 0):
					heavyAmmo -= 1
					create_projectile()
				else:
					weapon_swap(primary_weapon)
			else:
				if(!heavyAmmoReserves > 0):
					weapon_swap(primary_weapon)
				else:
					reload()
					

## Handles creating projectiles
var offsetSwap = false

func reload():
	if(active_weapon is Primary_Weapon):
		reloadSpeed.wait_time = active_weapon.reload_speed
	else:
		heavyAmmoReserves+=heavyAmmo
	reloadSpeed.wait_time = active_weapon.reload_speed
	SignalBus.emit("player_reloading", active_weapon.reload_speed)
	reloadSpeed.start()


func create_projectile():
	## Standard Procedure
	var instance = projectile.instantiate()
	instance.dir = rotation
	instance.spawnPos = global_position
	instance.spawnRot = global_rotation
	instance.playerObj = self
	offsetSwap = !offsetSwap
	
	## Based on weapon
	instance.SPEED = active_weapon.projectile_speed
	instance.offsetMain = active_weapon.y_offset
	instance.offsetSecondary = active_weapon.x_offset * (1 if offsetSwap else -1)
	instance.damage = active_weapon.damage
	
	## Creating the projectile
	main.add_child.call_deferred(instance)


## Updates stats and animations for new active weapon
func weapon_swap(weapon: Weapon_Parent):
	$Weapon.texture = load(weapon.sprite)
	active_weapon = weapon
	if(weapon is Primary_Weapon || (weapon is Heavy_Weapon && weapon.gun_or_melee)):
		fireRateRefresh.wait_time = active_weapon.fire_rate
		match(weapon.weapon_type):
			0:
				$Body.play("One Handed")
			1:
				$Body.play("Akimbo")
			2:
				$Body.play("Two Handed")
	elif(weapon is Melee_Weapon || (weapon is Heavy_Weapon && !weapon.gun_or_melee)):
		fireRateRefresh.wait_time = active_weapon.recovery
		swingingSpeed.wait_time = active_weapon.speed
		if(weapon.single_handed):
			$Body.play("One Handed Melee")
		else:
			$Body.play("Two Handed Melee")
	elif(weapon is Throwable_Weapon):
		pass
	else:
		print("Passed in invalid variable to weapon swap")


## Signals
func enemy_hurt(player: int, inSmoke: bool, weapon: Resource, conditions: int):
	if(player == playerSimpleID):
		print("Yay")

func on_reload_speed_timeout():
	print("Made it here")
	if(active_weapon is Primary_Weapon):
		if(!active_weapon.fire_mode == 8):
			primaryAmmo = MAXPRIMARYAMMO
		else: ## Shell reloading
			pass
	else:
		if(!active_weapon.fire_mode == 8):
			heavyAmmo = clamp(MAXHEAVYAMMORESERVES, 0, MAXHEAVYAMMO)
			heavyAmmoReserves -= heavyAmmo
		else: ## Shell reloading
			pass
