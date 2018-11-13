extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	randomize()
	
	#Color bars
	var grey_scale = (randf()-0.3)
	$Sprite.modulate = Color(grey_scale,grey_scale,grey_scale)
	$Sprite2.modulate = Color(0.9,0.75,0.1) #GoldenRod
	#$Sprite2.modulate = Color(randf(), randf(), randf())
	
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
