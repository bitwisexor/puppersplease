extends Sprite2D
var timer
var timer_display
var start_time = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	timer = $Timer
	timer_display = $countdown_timer
	start_time = timer.wait_time
	timer.start()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_timer_timeout():
	var time_left = int(timer_display.text) - 1
	timer_display.text = str(time_left)
	
