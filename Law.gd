extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

#LAW FIELDS
#Ex. Code MXII SoS 3.7
var code 
var section
var article
var text #the cow latin text
#----------
#Interpretation TYPES
# 0 - Fine
# 1 - Prison
# 2 - Execution
# 3 - [META] Disables other Laws
var law_type
var law_parameters #a variable to hold info about the type (fine amt, jail time, execution type, other laws)

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	randomize()
	
	#Come up with the parameters of the LAW
	code = Laws.gen_latin_numerals(randi()%1000000)
	section = randi()%100 + 1
	article = randi()%20
	text = Laws.gen_latin_sentence()
	
	$Sprite.modulate = Color(randf(), randf(), randf())
	$Sprite2.modulate = Color(randf(), randf(), randf())
	
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

#Prints out all the information about the law
func print_law():
	print("Code " + code + " Section " + str(section) + "." + str(article) )
	print(text)
	