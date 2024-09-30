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
	#SignalBus.enemy_killed.connect(enemy_killed)
	## Set Up
	set_up_player()


## Will set all variables to what they are ment to be
func set_up_player():
	if(weaponOveride != null):
		primary_weapon = weaponOveride
		
		MAXPRIMARYAMMO = primary_weapon.max_ammo
		primaryAmmo = MAXPRIMARYAMMO
		
		active_weapon = primary_weapon
		weapon_swap()
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
		throwables = player.starting_throwables
		
		
		## Player
		VIT = 0
		AGI = 0
		LUK = 0
		
		active_weapon = primary_weapon
		weapon_swap()
	else:
		print("User Null")


func _physics_process(_delta):
	## Movement
	
	#print($RayCast2D.is_colliding())
	
	## Movenment
	var direction = Input.get_vector("Left", "Right", "Up", "Down")
	direction.normalized()
	velocity = direction * SPEED
	
	
	
	## Inputs
	#if((Input.is_action_pressed("Fire")) && 
	#fireRateRefresh.is_stopped() && reloadSpeed.is_stopped()): 
		### Make it so it detects auto or not auto
		#if(active_weapon is Throwable_Weapon):
			#attack()
		#else:
			#attack()
	#elif(false && Input.is_action_pressed("Melee")):
		#weapon_swap(melee_weapon)
		#if(active_weapon is Throwable_Weapon):
			#attack()
		#else:
			#attack()
		##weapon_swap(Melee_Weapon)
		##attack(false)
	#elif(Input.is_action_just_pressed("Reload") && reloadSpeed.is_stopped()):
		#if(active_weapon is Primary_Weapon && (primaryAmmo != MAXPRIMARYAMMO)):
			#reload()
		#elif(active_weapon is Heavy_Weapon && (heavyAmmo != MAXHEAVYAMMO)):
			#reload()
	#elif(Input.is_action_pressed("Throwable")):
		#if(!active_weapon is Throwable_Weapon):
			#weapon_swap(throwable_weapon)
		#else:
			#weapon_swap(primary_weapon)
	#elif(Input.is_action_just_pressed("Swap Gun")):
		#if(!reloadSpeed.is_stopped()):
			#reloadCancel = true
			#reloadSpeed.stop()
		#if(!active_weapon is Heavy_Weapon):
			#weapon_swap(heavy_weapon)
		#else:
			#weapon_swap(primary_weapon)
	#
	if($"Timers/Swinging Speed".is_stopped() && $Timers/Attacking.is_stopped()):
		
		## For attacking with melee weapon
		if(Input.is_action_pressed("Melee")):
			melee_attack(true) ## Will be false if heavy attack is melee based
		
		## Swap to throwable weapon
		elif(Input.is_action_just_pressed("Throwable")):
			#throwable_swap() ## Will swap to throwable weapon
			pass
		
		## Reloads active weapon
		elif(Input.is_action_just_pressed("Reload")):
			reload() # Rework reload script
		
		## 
		elif(Input.is_action_just_pressed("Swap Gun")):
			weapon_swap()
			pass
		
		## For attacking with active weapon
		elif(Input.is_action_pressed("Fire") && fireRateRefresh.is_stopped()
		 && reloadSpeed.is_stopped()): ## And melee cooldown 1, and not swinging
			#attack() # Rework attack script
			pass
		
	
	
	## Makes you look at cursor
	look_at(get_global_mouse_position())
	
	## Applies movement
	move_and_slide()


## Vars for 
var active_weapon: Weapon_Parent ## Active weapon to easy grab data without checking type
var primary_or_heavy := true ## true for primary
var throwable_on := false ## for if throwable is equiped


## Attack for melees
func melee_attack(Heavy: bool):
	pass


## Swap to Throwable weapon
func throwable_swap():
	throwable_on = !throwable_on
	if(throwable_on):
		active_weapon = throwable_weapon
	else:
		active_weapon = primary_weapon if primary_or_heavy else heavy_weapon


## Reloads weaponry
func reload():
	if(primary_or_heavy): ## Primary reload
		pass
	else: #elif(heavy.is_reloadable): ## Heavy reload 
		pass


## Swaps between primary and heavy
func weapon_swap():
	primary_or_heavy = !primary_or_heavy
	if(primary_or_heavy): ## Primary weapon swap to
		active_weapon = primary_weapon
	else: ## Heavy weapon swap to
		active_weapon = heavy_weapon
	sprite_swap() ## Primary sprite swap to


## attacking with primary, heavy, or throwable
func attack():
	if(throwable_on): ## Throwable throw
		pass
	elif(primary_or_heavy): ## Primary weapon attack
		pass
	else: ## Heavy weapon attack
		pass


## Swaps weapon sprites
func sprite_swap():
	if(throwable_on): ## Swap to throwable animation
		pass
	if(primary_or_heavy): ## Primary sprite swap to
		pass
	elif(active_weapon is Melee_Weapon): ## Swap to melee attack animation
		pass
	else: ## Heavy swap to
		if(heavy_weapon.gun_or_melee): ## Firearm
			pass
		else: ## Melee
			pass










## Will handle what to do based on active weapon when attack buttons are pressed
#func attack():
	#if(active_weapon is Primary_Weapon):
		#if(primaryAmmo > 0):
			#primaryAmmo -= 1
			#fireRateRefresh.start()
			#create_projectile()
		#else:
			#reload()
	#elif(active_weapon is Heavy_Weapon):
		#if(heavyAmmo > 0):
			#heavyAmmo -= 1
			#fireRateRefresh.start()
			#create_projectile()
		#else:
			#if(!heavyAmmoReserves > 0):
				#weapon_swap(primary_weapon)
			#else:
				#reload()
	#elif(active_weapon is Melee_Weapon):
		#pass
	#elif(active_weapon is Throwable_Weapon):
		#pass


## Handles creating projectiles
#var offsetSwap = false
#
#func reload():
	#reloadSpeed.wait_time = active_weapon.reload_speed
	#reloadSpeed.start()
	#if(active_weapon is Heavy_Weapon):
		#heavyAmmoReserves+=heavyAmmo
		#heavyAmmo = 0
	#else:
		#primaryAmmo = 0
	#SignalBus.player_reloading.emit(active_weapon.reload_speed)
#
#
#func set_projectile():
	#
	### Standard Procedure
	#var instance = projectile.instantiate()
	#instance.dir = rotation
	#instance.spawnPos = global_position
	#instance.spawnRot = global_rotation
	#instance.playerObj = self
	#offsetSwap = !offsetSwap
	##instance.attackID = attackID
	#
	### Based on weapon
	#instance.SPEED = active_weapon.projectile_speed
	#instance.offsetMain = active_weapon.y_offset
	#instance.offsetSecondary = active_weapon.x_offset * (1 if offsetSwap else -1)
	#instance.damage = active_weapon.damage 
	#
	### Luck based changes
	#if(active_weapon.fire_mode != 8):
		#pass
	#
	#return instance
#
#
#var attackID = 0
#
#func create_projectile():
	### Creating the projectile
	#if(active_weapon.fire_mode == 8):
		#for i in active_weapon.pellet_count:
			#var instance = set_projectile()
			#instance.damage /= active_weapon.pellet_count
			#instance.dir += deg_to_rad(randi_range(active_weapon.spread*-1,active_weapon.spread))
			#main.add_child.call_deferred(instance)
	#else:
		#var instance = set_projectile()
		#main.add_child.call_deferred(instance)
	#attackID += 1


## Updates stats and animations for new active weapon
#func weapon_swap(weapon: Weapon_Parent):
	#$Weapon.texture = load(weapon.sprite)
	#active_weapon = weapon
	#if(weapon is Primary_Weapon || (weapon is Heavy_Weapon && weapon.gun_or_melee)):
		#fireRateRefresh.wait_time = active_weapon.fire_rate
		#match(weapon.weapon_type):
			#0:
				#$Body.play("One Handed")
				#$Weapon.z_index = z_index
			#1:
				#$Body.play("Akimbo")
				#$Weapon.z_index = z_index
			#2:
				#$Body.play("Two Handed")
				#$Weapon.z_index = z_index+1
	#elif(weapon is Melee_Weapon || (weapon is Heavy_Weapon && !weapon.gun_or_melee)):
		#fireRateRefresh.wait_time = active_weapon.recovery
		#swingingSpeed.wait_time = active_weapon.speed
		#if(weapon.single_handed):
			#$Body.play("One Handed Melee")
		#else:
			#$Body.play("Two Handed Melee")
	#elif(weapon is Throwable_Weapon):
		#pass
	#else:
		#print("Passed in invalid variable to weapon swap")


## Node signals
func _on_reload_speed_timeout(): # Rework this script
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
				heavyAmmo = clamp(heavyAmmoReserves, 0, MAXHEAVYAMMO)
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


## Connected Signals
func enemy_hurt(player: int, inSmoke: bool, weapon: Resource, conditions: int):
	if(player == playerSimpleID):
		pass
