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
@export var playerSimpleID = 0 ## For simple checks to see if you are the proper user

## Variables
var priority := 0
var SPEED = 300.0 ## Shouldn't be changed after being set

var reloadCancel = false

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
		heavyAmmo = MAXHEAVYAMMO # Set to 0 or make new variable when no debug
		MAXHEAVYAMMORESERVES = heavy_weapon.max_reserves
		heavyAmmoReserves = MAXHEAVYAMMORESERVES # Always set to 0, only for debug
		
		## Throwable
		MAXTHROWABLES = throwable_weapon.max_throwables
		#throwables = player.starting_throwables
		
		## Player
		VIT = 0
		AGI = 0
		LUK = 0
		
		weapon_swap(primary_weapon)
	else:
		print("User Null")


func _physics_process(_delta):
	## Movement
	var direction = Input.get_vector("Left", "Right", "Up", "Down")
	direction.normalized()
	velocity = direction * SPEED
	
	## Checks if you can fire main weapon
	if((true && Input.is_action_pressed("Fire")) && fireRateRefresh.is_stopped() && reloadSpeed.is_stopped()): 
		## Make it so it detects auto or not auto
		if(active_weapon is Throwable_Weapon):
			attack(false)
		else:
			attack(true)
	elif(false && Input.is_action_pressed("Melee")):
		if(active_weapon is Throwable_Weapon):
			attack(false)
		else:
			attack(false)
		#weapon_swap(Melee_Weapon)
		#attack(false)
	elif(Input.is_action_just_pressed("Reload") && reloadSpeed.is_stopped()):
		if(active_weapon is Primary_Weapon && (primaryAmmo != MAXPRIMARYAMMO)):
			reload()
		elif(active_weapon is Heavy_Weapon && (heavyAmmo != MAXHEAVYAMMO)):
			reload()
	elif(Input.is_action_pressed("Throwable")):
		if(!active_weapon is Throwable_Weapon):
			weapon_swap(throwable_weapon)
		else:
			weapon_swap(primary_weapon)
	elif(Input.is_action_just_pressed("Swap Gun")):
		if(!reloadSpeed.is_stopped()):
			reloadCancel = true
			reloadSpeed.stop()
		if(!active_weapon is Heavy_Weapon):
			weapon_swap(heavy_weapon)
		else:
			weapon_swap(primary_weapon)
	
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
				heavyAmmo -= 1
				fireRateRefresh.start()
				create_projectile()
			else:
				if(!heavyAmmoReserves > 0):
					weapon_swap(primary_weapon)
				else:
					reload()
					

## Handles creating projectiles
var offsetSwap = false

func reload():
	reloadSpeed.wait_time = active_weapon.reload_speed
	reloadSpeed.start()
	if(active_weapon is Heavy_Weapon):
		heavyAmmoReserves+=heavyAmmo
		heavyAmmo = 0
	else:
		primaryAmmo = 0
	SignalBus.player_reloading.emit(active_weapon.reload_speed)

func set_projectile():
	
	## Standard Procedure
	var instance = projectile.instantiate()
	instance.dir = rotation
	instance.spawnPos = global_position
	instance.spawnRot = global_rotation
	instance.playerObj = self
	offsetSwap = !offsetSwap
	#instance.attackID = attackID
	
	## Based on weapon
	instance.SPEED = active_weapon.projectile_speed
	instance.offsetMain = active_weapon.y_offset
	instance.offsetSecondary = active_weapon.x_offset * (1 if offsetSwap else -1)
	instance.damage = active_weapon.damage 
	
	## Luck based changes
	if(active_weapon.fire_mode != 8):
		pass
	
	return instance


var attackID = 0

func create_projectile():
	## Creating the projectile
	if(active_weapon.fire_mode == 8):
		for i in active_weapon.pellet_count:
			var instance = set_projectile()
			instance.damage /= active_weapon.pellet_count
			instance.dir += deg_to_rad(randi_range(active_weapon.spread*-1,active_weapon.spread))
			main.add_child.call_deferred(instance)
	else:
		var instance = set_projectile()
		main.add_child.call_deferred(instance)
	attackID += 1


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
		pass

func _on_reload_speed_timeout():
	if(!reloadCancel):
		if(active_weapon is Primary_Weapon):
			if(active_weapon.magizine):
				primaryAmmo = MAXPRIMARYAMMO
			else: ## Shell reloading
				if(primaryAmmo+1 == MAXPRIMARYAMMO):
					primaryAmmo = MAXPRIMARYAMMO
				else:
					primaryAmmo+=1
					reloadSpeed.start()
					SignalBus.player_reloading.emit(active_weapon.reload_speed)
		else:
			if(active_weapon.magizine):
				heavyAmmo = clamp(MAXHEAVYAMMORESERVES, 0, MAXHEAVYAMMO)
				heavyAmmoReserves -= heavyAmmo
			else: ## Shell reloading
				if(heavyAmmo+1 == MAXHEAVYAMMO):
					heavyAmmo = MAXHEAVYAMMO
				else:
					heavyAmmo+=1
					heavyAmmoReserves-=1
					if(heavyAmmoReserves != 0):
						reloadSpeed.start()
						SignalBus.player_reloading.emit(active_weapon.reload_speed)
	else:
		reloadCancel = false
