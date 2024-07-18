extends Node2D


@onready var tile_map = $Map
#@onready var character = $Raccoon.global_position
#@onready var charToTileMapPosition = tile_map.to_local(character)
#@onready var charCellcoords = tile_map.world_to_map(charToTileMapPosition)
#@onready var charExactTile = tile_map.get_cellv(character)

var sand = 1

		
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
	


func _input(event):
	if Input.is_action_just_pressed("place_block"):
		print("ze bomb has been planted")
		var character = $Raccoon.global_position
		var charToTileMapPosition : Vector2i = tile_map.local_to_map(character)
		var source_id = 1
		var atlastCoords: Vector2i = Vector2i(1,0)
		
		
		
		tile_map.set_cell(sand, charToTileMapPosition, source_id, atlastCoords)
		
		
		
	
