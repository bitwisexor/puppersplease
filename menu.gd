class_name Menu
extends Control
signal clicked_play

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_quit_pressed():
	get_tree().quit() # Tells the game to exit if "Quit" is clicked

func _on_optionsbutton_pressed():
	pass

func _on_quitbutton_pressed():
	get_tree().quit() # Exit game if quit is pressed


func _on_startbutton_pressed():
	Fade.fade_out(1, Color.BLACK, "Diamond", false, false)
	emit_signal("clicked_play")

