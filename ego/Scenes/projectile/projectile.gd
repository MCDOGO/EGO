extends CharacterBody2D

@export var SPEED = 1200
var weapon: Weapon_Parent = null
var playerID := 0

var dir : float
var spawnPos : Vector2
var spawnRot : float
var playerObj: CharacterBody2D

var offsetMain : int
var offsetSecondary : int = 0

var damage: int
var status_afflicted: int
var status_damage: int

var explossive: bool = false
var explossive_damage: int
var explossive_radius: int 
var explossive_duration: float ## Time
var explossive_smoke: bool = false

var is_explode := false

func _ready():
	global_position = spawnPos + Vector2(offsetMain,offsetSecondary).rotated(dir)
	global_rotation = spawnRot
	
	#$Sprite2D.texture = weapon.projectile_sprite
	#$Sprite2D.offset = weapon.projectile_offset * 2
	#var projectileSize = RectangleShape2D.new()
	
	#projectileSize.size = weapon.projectile_size
	#$CollisionShape2D.shape = projectileSize
	#$"Hit Enemy/CollisionShape2D".shape = projectileSize
	#$"Hit Wall/CollisionShape2D".shape = projectileSize

func _physics_process(_delta):
	if(!is_explode):
		velocity = Vector2(SPEED,0).rotated(dir)
		move_and_slide()

## Signals
func _on_lifespan_timeout():
	if(explossive):
		expload()
	queue_free()

func _on_hit_body_entered(_body):
	if(explossive):
		expload()
	queue_free()

func expload():
	is_explode = true
	var temp = CircleShape2D.new()
	temp.radius = explossive_radius
	$"Explosive/Explossive Radius/CollisionShape2D".shape = temp
	$"Explosive/Explossive Lifespan".wait_time = explossive_duration
	$"Explosive/Explossive Lifespan".start()

func _on_explossive_lifespan_timeout() -> void:
	queue_free()
