extends Node2D


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

		
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func _process(delta):
	char_pos = $Raccoon.global_position
	character_Position = tile_map.local_to_map(char_pos)
	if character_Position != charToTileMapPosition:
		tile_map.set_cell(sand, charToTileMapPosition, source_id_Wphysics, atlastCoords)


func _input(event):
	print_debug(event)
	if Input.is_action_just_pressed("place_block"):
		#position of the character
		character = $Raccoon.global_position
		#position cords
		charToTileMapPosition = tile_map.local_to_map(character)
		#id of the picture
		
		#position of the certain tile
		atlastCoords = Vector2i(1,0)
		#place a block
		tile_map.set_cell(sand, charToTileMapPosition, source_id_WOphysics, atlastCoords)
