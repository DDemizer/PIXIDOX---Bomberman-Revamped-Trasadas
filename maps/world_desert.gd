extends Node2D

var player1
var player2
var player3
var player4

@onready var tile_map = $Map
@onready var tile_map2 = $Desert_things
var char_pos
var character_Position : Vector2i
var character
var charToTileMapPosition : Vector2i
var atlastCoords : Vector2i
var tile_data : TileData
var source_id_WOphysics = 2
var source_id_Wphysics = 1

var sand = 1
var placed_by_player_custom_data = "placed_by_player"

var general_start_button = Input.is_action_just_pressed("general_start_button")
var up = 11
var down = 12
var left = 13
var right = 14
var start_button = 6
var select_button = 4
var green = 2
var blue = 3
var yellow = 0
var red = 1
var l1 = 9
var r1 = 10


		
# Called when the node enters the scene tree for the first time.
func _ready():
	if CharacterSelectionManager.player1 != null:
		player1 = CharacterSelectionManager.player1.instantiate()
	if CharacterSelectionManager.player2 != null:
		player2= CharacterSelectionManager.player2.instantiate()
	if CharacterSelectionManager.player3 != null:
		player3 = CharacterSelectionManager.player3.instantiate()
	if CharacterSelectionManager.player4 != null:
		player4 = CharacterSelectionManager.player4.instantiate()
	SpawnCharacters()
	
func SpawnCharacters():
	# Player 1 Position
	if player1 != null:
		player1.position.x = 514
		player1.position.y = 96
		player1.player = 0
		call_deferred("add_child", player1)
		print_debug('Player 1 Controller: ', player1.player)
		
		
	# Player 2 Position
	if player2 != null:
		player2.position.x = 1407 
		player2.position.y = 96
		player2.player = 1
		call_deferred("add_child", player2)
		print_debug('Player 2 Controller: ', player2.player)
#
#	# Player 3 Position
	if player3 != null: 
		player3.position.x = 514 
		player3.position.y = 986
		player3.player = 2
		call_deferred("add_child", player3)
		print_debug('Player 3 Controller: ', player3.player)
#
#	# Player 4 Position
	if player4 != null: 
		player4.position.x = 1407
		player4.position.y = 986
		player4.player = 3
		call_deferred("add_child", player4) 
		print_debug('Player 4 Controller: ', player4.player)
#
	
#func _process(delta):
#	char_pos = $Raccoon.global_position
#	character_Position = tile_map.local_to_map(char_pos)
#	if character_Position != charToTileMapPosition:
#		tile_map.set_cell(sand, charToTileMapPosition, source_id_Wphysics, atlastCoords)
#
#
#func _input(event):
#	print_debug(event)
#	if Input.is_joy_button_pressed(0, blue):
#		#position of the character
#		character = $Raccoon.global_position
#		#position cords
#		charToTileMapPosition = tile_map.local_to_map(character)
#		#id of the picture
#
#		#position of the certain tile
#		atlastCoords = Vector2i(1,0)
#		#place a block
#		tile_map.set_cell(sand, charToTileMapPosition, source_id_WOphysics, atlastCoords)
