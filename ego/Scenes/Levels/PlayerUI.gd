extends CanvasLayer

var max_time: float

func _ready() -> void:
	SignalBus.connect("player_reloading", reload_bar)


func _process(delta: float) -> void:
	$ProgressBar.value = $Timer.time_left/max_time


func reload_bar(time):
	max_time = time
	$Timer.start(max_time)
