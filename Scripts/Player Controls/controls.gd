extends CharacterBody2D

const SPEED = 70
#const JUMP_VELOCITY = -400.0
# NODES
@onready var animation = get_node("AnimationPlayer")
@onready var sprite = $AnimatedSprite2D
@export var player = 0

# Buttons
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

#@onready var parent = get_parent()
@onready var tile_map = $"../Map"
@onready var bomb = $"../Bomb"
#@onready var tile_map2 = $"../Desert_things"
var placed_block = false
var placed_bomb = false
var char_pos
var character_Position : Vector2i
var character
var charToTileMapPosition : Vector2i
var atlastCoords : Vector2i
#var tile_data : TileData
var source_id_WOphysics = 2
var source_id_Wphysics = 1

var sand = 1
var placed_by_player_custom_data = "placed_by_player"

var atlastCoordsBomb : Vector2i = Vector2i(0,0)
var bombId_WOphysics = 0
var bombId_Wphysics = 1
var bombId_lvl1 = 2
var bomId_lvl2 = 3
var bombId_lvl3 = 4
var if_is_ground = 'is_ground'

func _physics_process(delta):
	# buttons
	var up_button = Input.is_joy_button_pressed(player, up)
	var down_button = Input.is_joy_button_pressed(player, down)
	var right_button = Input.is_joy_button_pressed(player, right)
	var left_button = Input.is_joy_button_pressed(player, left)
	var place_bomb = Input.is_joy_button_pressed(player, green)
	var escape = Input.is_action_just_pressed('ui_cancel')
	
	# WALKING
	if up_button or down_button:
		if up_button:
			velocity.y = -SPEED
			if not right_button and not left_button:
				animation.play('up')
		if down_button:
			velocity.y = SPEED
			if not right_button and not left_button:
				animation.play('down')
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)
		
	if right_button or left_button:
		if right_button or (right_button and up_button) or (right_button and down_button):
			sprite.flip_h = false
			animation.play('side')
			velocity.x = SPEED
		if left_button or (left_button and up_button) or (left_button and down_button):
			sprite.flip_h = true
			animation.play('side')
			velocity.x = -SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		sprite.flip_h = false
#	
	if not (up_button or down_button or left_button or right_button):
		animation.play('idle')
		
		
	if place_bomb:
		pass
	
	if escape:
		get_tree().quit()
	move_and_slide()

func _process(delta):
	if placed_block == true:	
		char_pos = self.global_position
		character_Position = tile_map.local_to_map(char_pos)
		if character_Position != charToTileMapPosition:
			tile_map.set_cell(sand, charToTileMapPosition, source_id_Wphysics, atlastCoords)
			placed_block = false
	if placed_bomb == true:
		char_pos = self.global_position
		character_Position = bomb.local_to_map(char_pos)
		if character_Position != charToTileMapPosition:
			bomb.set_cell(0,charToTileMapPosition, bombId_Wphysics, atlastCoordsBomb)
			placed_bomb = false
#			bomb_handler(charToTileMapPosition)

	
			

func _input(event):
	if Input.is_joy_button_pressed(player, blue):
		#position of the character
		character = self.global_position
		#position cords
		charToTileMapPosition = tile_map.local_to_map(character)
		#position of the certain tile
		atlastCoords = Vector2i(1,0)
		#place a block
		tile_map.set_cell(sand, charToTileMapPosition, source_id_WOphysics, atlastCoords)
		placed_block = true
		
	if Input.is_joy_button_pressed(player, green):
		
		#position of the character
		character = self.global_position
		#position coords
		charToTileMapPosition = bomb.local_to_map(character)
		#place the bomb
#		if tile_data(tile_map, sand, charToTileMapPosition) == true:
		var xx : TileData = tile_map.get_cell_tile_data(0, charToTileMapPosition)
		print(xx)
		bomb.set_cell(2 ,charToTileMapPosition, bombId_WOphysics, atlastCoordsBomb)
		placed_bomb = true 
		
func bomb_handler(bomb_position):     
	if placed_bomb == true:
		bomb.set_cell(0,bomb_position, bombId_Wphysics, atlastCoordsBomb)
		await get_tree().create_timer(0.45).timeout
		bomb.set_cell(0,bomb_position, bombId_Wphysics, atlastCoordsBomb.x + 1)
		await get_tree().create_timer(0.45).timeout
		bomb.set_cell(0,bomb_position, bombId_Wphysics, atlastCoordsBomb.x + 2)
		await get_tree().create_timer(0.45).timeout
		bomb.set_cell(0,bomb_position, bombId_Wphysics, atlastCoordsBomb.x + 3)
		await get_tree().create_timer(0.45).timeout
		bomb.set_cell(0,bomb_position, bombId_Wphysics, atlastCoordsBomb.x + 4)
		await get_tree().create_timer(0.45).timeout
		bomb.set_cell(0,bomb_position, bombId_Wphysics, atlastCoordsBomb.x + 5)
		await get_tree().create_timer(0.45).timeout
		placed_bomb = false
		
			

func tile_data(tilemap : TileMap, ground_layer :int, character_position: Vector2i):
	return tilemap.get_cell_tile_data(ground_layer, character_position)
