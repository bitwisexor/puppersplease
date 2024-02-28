class_name Gameman
extends Node


# Function to load and instantiate a scene additively
func load_scene_additively(scene_path: String):
	# Load the scene
	var scene_to_load = load(scene_path) # Use preload() if you know the scene at compile time
	if scene_to_load:
		# Instantiate the scene
		var instance = scene_to_load.instantiate()
		add_child(instance)
		
		return instance
	else:
		print("Failed to load scene:", scene_path)

func sendtext():
	print("test 123")
	
# Called when the node enters the scene tree for the first time.
func _ready():
	var loaded: Menu = load_scene_additively("res://menu.tscn")
	loaded.clicked_play.connect(clicked_play)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func clicked_play():
	var menu_node = get_node("Menu")
	
	remove_child(menu_node)
	menu_node.queue_free() # TODO: Find out if neccessary
	var main: Main = load_scene_additively("res://main.tscn")
