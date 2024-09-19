extends CanvasLayer

var max_time: float
var ID: int
var player: CharacterBody2D

func _ready():
	SignalBus.player_reloading.connect(reload_bar)
	player = get_tree().current_scene.get_player(ID)
	ID = 0


func _process(_delta: float):
	$ProgressBar.value = 100 * $Timer.time_left/max_time
	if(player.active_weapon is Heavy_Weapon):
		$Label.text = str(player.heavyAmmo) + " / " + str(player.MAXHEAVYAMMO) + " | " + str(player.heavyAmmoReserves)
	elif(player.active_weapon is Primary_Weapon):
		$Label.text = str(player.primaryAmmo) + " / " + str(player.MAXPRIMARYAMMO)
	elif(player.active_weapon is Throwable_Weapon):
		$Label.text = str(player.throwables)
		


func reload_bar(time):
	max_time = time
	$Timer.start(max_time)
