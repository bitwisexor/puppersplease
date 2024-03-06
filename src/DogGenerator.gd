extends Node

var dog_folder = "res://resources/dogs/"
var trait_folder = "res://resources/traits/"
var exclusions_folder = "res://resources/exclusions/"

var exclusions_list = []

# Called when the node enters the scene tree for the first time.
func _ready():
	create_exclusions_dict()
	print("Generator started! Generating dog.")
	
	var dog = get_random_dog()
	print(dog.name)
	print(dog.description)
	print(dog.traits.map(func(t: TraitResource): return t.name))
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func create_exclusions_dict():
	var dir = DirAccess.open(exclusions_folder)
	var files = dir.get_files()
	
	for f in files:
		var exclusion = load(exclusions_folder + f) as TraitExclusionResource
		exclusions_list.append(clean_trait_file_names([ exclusion.trait_a, exclusion.trait_b]))
	
func are_traits_exclusive(trait_a: String, trait_b: String) -> bool:
	for pair in exclusions_list:
		var x = pair[0] == trait_a && pair[1] == trait_b
		var y = pair[0] == trait_b && pair[1] == trait_a
		
		if x || y:
			return false
			
	return true

func get_random_dog() -> DogResource:
	var dir = DirAccess.open(dog_folder)
	var files = dir.get_files()
	var rand = randi() % files.size()
	var dog = files[rand]
	var dog_file = dog_folder + dog
	
	var loaded_dog: DogResource = load(dog_file) as DogResource
	
	add_random_trait(loaded_dog)
	add_random_trait(loaded_dog)
	
	return loaded_dog
	
# Can't use Array[string] here at all because results from .map aren't typed correctly
func clean_trait_file_names(array: Array):
	return array.map(func(f: String) -> String: return f.replace(".tres", "").replace(trait_folder, "")) as Array[String]
	
func add_random_trait(dog: DogResource):
	var current_traits_exts = dog.traits.map(func(t: TraitResource): return t.resource_path)
	var current_traits = clean_trait_file_names(current_traits_exts)
	
	var dir = DirAccess.open(trait_folder)
	var trait_files_exts = dir.get_files()
	var trait_files = clean_trait_file_names(trait_files_exts)
	

	# Loop over both current and possible traits and find exclusions between the two, also exclude existing traits
	var usable_traits = trait_files.filter(func(f: String): return current_traits.find(f) == -1 && current_traits.all(func(t: String): return are_traits_exclusive(f, t)))
	
	if usable_traits.size() != 0:
		var rand = randi() % usable_traits.size()
		var picked_trait = usable_traits[rand]
		var traitr = load(trait_folder + picked_trait + ".tres")
		
		dog.traits.append(traitr)
