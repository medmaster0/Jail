extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

export (PackedScene) var JailCell
export (PackedScene) var Creature

var background_color

var map_jail_cells = [] #Array to hold all of the created jail cells
var map_prisoners = [] #Array to hold all of the created creatures

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	randomize()
	
	#Set up background
	background_color = Color(randf(), randf(), randf())
	$CanvasLayer/Background.scale = get_viewport().size
	$CanvasLayer/Background.set_modulate( background_color )
	
	#Color Backgrounds
	$FloorMapPrim.self_modulate = Color(randf(), randf(), randf())
	$FloorMapSeco.self_modulate = Color(randf(), randf(), randf())
	$WallMapPrim.self_modulate = Color(randf(), randf(), randf())
	$WallMapSeco.self_modulate = Color(randf(), randf(), randf())
	
	#Setup Main Player
	$WallMapPrim/Creature.is_main = true
	
	$Law.print_law()
	
	#Create Jail Cells
#	var jail_cell = JailCell.instance()
#	jail_cell.position = $FloorMapPrim.map_to_world(Vector2(11,11))
#	add_child(jail_cell)
	
	var jail_cell #temp var for each jail cell
	var jail_x = 8 #The top left corner of the jail house
	var jail_y = 8 #The top left corner of the jail house
	var num_cols = 4 ##columns of cell x dir
	var num_rows = 6 #Rows of cells y dir
	
	for i in range(num_cols): #columns of cell x dir
	
		for j in range(num_rows): #Rows of cells y dir
			jail_cell = JailCell.instance()
			jail_cell.position = $FloorMapPrim.map_to_world(Vector2(jail_x+4*i,jail_y+4*j ))
			add_child(jail_cell)
			map_jail_cells.append(jail_cell)
		
			#Possibly add a Creature in there
			if randi()%3 == 0:
				var prisoner = Creature.instance()
				prisoner.position = $FloorMapPrim.map_to_world(Vector2(jail_x+4*i+randi()%2,jail_y+4*j+1 ))
				$WallMapPrim.add_child(prisoner)
				map_prisoners.append(prisoner)
				prisoner.zodiac_tile.get_child(prisoner.zodiac_sign).visible = false
				
		
			#Draw the floor
			for z in range(4):
				$FloorMapPrim.set_cell(jail_x+4*i+z, jail_y+4*j+2, 0)
				$FloorMapSeco.set_cell(jail_x+4*i+z, jail_y+4*j+2, 1)
				
			#Draw the left wall
			for z in range(3):
				$WallMapPrim.set_cell(jail_x+4*i-1, jail_y+4*j+z-1, 2 )
				$WallMapSeco.set_cell(jail_x+4*i-1, jail_y+4*j+z-1, 3 )
				
			#Draw Top Wall
			for z in range(4):
				$WallMapPrim.set_cell(jail_x+4*i+z, jail_y+4*j-1, 2 )
				$WallMapSeco.set_cell(jail_x+4*i+z, jail_y+4*j-1, 3 )
				
			#Also blocks on first column
			#at end of path
			if i == 0:
				$WallMapPrim.set_cell(jail_x+4*i-1, jail_y+4*j+2, 2 )
				$WallMapSeco.set_cell(jail_x+4*i-1, jail_y+4*j+2, 3 )
				
			#Also Blocks on last column
			if i == num_cols-1:
				#BRICKS Directly Above path
				$WallMapPrim.set_cell(jail_x+4*i+3, jail_y+4*j+1, 2)
				$WallMapSeco.set_cell(jail_x+4*i+3, jail_y+4*j+1, 3)
				
				#BRICKS two Above path
				$WallMapPrim.set_cell(jail_x+4*i+3, jail_y+4*j, 2)
				$WallMapSeco.set_cell(jail_x+4*i+3, jail_y+4*j, 3)
		

	print(map_jail_cells.size())
	print(map_prisoners.size())

	pass

var total_delta = 0
var tick_period = 0.5 #the seconds that a tick oocurs
func _process(delta):
	# Called every frame. Delta is time since last frame.
	# Update game logic here.
	total_delta = total_delta + delta
	
	if total_delta > tick_period:
		print("tick")
		
		#Choose a random prisoner
		var rand_prisoner = map_prisoners[randi()%map_prisoners.size()]
		#Step in random directions
		if randi()%2 == 0:
			rand_prisoner.step(Vector2(1,0))
		else:
			rand_prisoner.step(Vector2(-1,0))
		print(rand_prisoner.position)
		rand_prisoner.update()
		
		total_delta = total_delta - tick_period
	
	pass
