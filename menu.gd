extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_quit_pressed():
	get_tree().quit() # Tells the game to exit if "Quit" is clicked

func _on_optionsbutton_pressed():
	get_node("burning").play()


func _on_quitbutton_pressed():
	get_tree().quit()
