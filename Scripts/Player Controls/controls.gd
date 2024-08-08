extends CharacterBody2D

const SPEED = 70
#const JUMP_VELOCITY = -400.0
# NODES
@onready var animation = get_node("AnimationPlayer")
@onready var sprite = $AnimatedSprite2D
@export var player = 0

# Buttons
var general_start_button = Input.is_action_just_pressed("general_start_button")
var general_select_button = Input.is_action_just_pressed("general_select_button")
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

# bomb
var current_anim : Vector2i
var bomb_hit = false
var is_breakable = 'breakable'
var s1center : TileData
var s2left : TileData
var s3right : TileData
var s4down : TileData
var s5upper : TileData

signal build1_activated
signal build2_activated
signal build3_activated
signal build4_activated

func _ready():
	connect('build1_activated', BattleManager.on_build1_activated)
	connect('build2_activated', BattleManager.on_build2_activated)
	connect('build3_activated', BattleManager.on_build3_activated)
	connect('build4_activated', BattleManager.on_build4_activated)

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
	
	# SHOULD BE FOR PAUSING
	if Input.is_joy_button_pressed(player, start_button):
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
		if BattleManager.build1_active:
			place_block()
			BattleManager.build1_active = false
			emit_signal('build1_activated')
		if BattleManager.build2_active:
			place_block()
			BattleManager.build2_active = false
			emit_signal('build2_activated')
		if BattleManager.build3_active:
			place_block()
			BattleManager.build3_active = false
			emit_signal('build3_activated')
		if BattleManager.build4_active:
			place_block()
			BattleManager.build4_active = false
			emit_signal('build4_activated')
		
	if Input.is_joy_button_pressed(player, green):
		place_bomb()
		
func place_bomb():
#position of the character
	character = self.global_position
	
	#position coords
	charToTileMapPosition = bomb.local_to_map(character)
	#place the bomb
#		if tile_data(tile_map, sand, charToTileMapPosition) == true:
	var xx : TileData = tile_map.get_cell_tile_data(0, charToTileMapPosition)
	
#		bomb.set_cell(2 ,charToTileMapPosition, bombId_WOphysics, atlastCoordsBomb)
	placed_bomb = true 
	bomb_handler(charToTileMapPosition)
	
func place_block():
	#position of the character
	character = self.global_position
	#position cords
	charToTileMapPosition = tile_map.local_to_map(character)
	#position of the certain tile
	atlastCoords = Vector2i(1,0)
	#place a block
	tile_map.set_cell(sand, charToTileMapPosition, source_id_WOphysics, atlastCoords)
	placed_block = true
	

func bomb_handler(bomb_position):     
	if placed_bomb:
		var bombs = Vector2i(bomb_position.x, bomb_position.y)
		current_anim = Vector2i(atlastCoordsBomb.x, atlastCoordsBomb.y)
		bomb.set_cell(0,bombs, bombId_Wphysics, atlastCoordsBomb)
		await get_tree().create_timer(0.45).timeout
		current_anim = Vector2i(current_anim.x + 1, current_anim.y)
		bomb.set_cell(0,bombs, bombId_Wphysics, current_anim)
		await get_tree().create_timer(0.45).timeout
		current_anim = Vector2i(current_anim.x + 1, current_anim.y)
		bomb.set_cell(0,bombs, bombId_Wphysics, current_anim)
		await get_tree().create_timer(0.45).timeout
		current_anim = Vector2i(current_anim.x + 1, current_anim.y)
		bomb.set_cell(0,bombs, bombId_Wphysics, current_anim)
		await get_tree().create_timer(0.45).timeout
		current_anim = Vector2i(current_anim.x + 1, current_anim.y)
		bomb.set_cell(0,bombs, bombId_Wphysics, current_anim)
		await get_tree().create_timer(0.45).timeout
		current_anim = Vector2i(current_anim.x + 1, current_anim.y)
		bomb.set_cell(0,bombs, bombId_Wphysics, current_anim)
		await get_tree().create_timer(0.45).timeout
		bomb_explosion(bomb_position)
		bomb.erase_cell(1, bombs)
		
		current_anim = atlastCoordsBomb
		placed_bomb = false
		
func bomb_explosion(bomb_position):
	var center : Vector2i = bomb_position
	var upper :Vector2i = Vector2i(center.x, center.y - 1)
	var left : Vector2i = Vector2i(center.x - 1, center.y)
	var right : Vector2i = Vector2i(center.x + 1, center.y)
	var down : Vector2i = Vector2i(center.x, center.y + 1)
	
	
	s1center = tile_map.get_cell_tile_data(1, center)
	s2left = tile_map.get_cell_tile_data(1, left)
	s3right = tile_map.get_cell_tile_data(1, right)
	s4down = tile_map.get_cell_tile_data(1, down)
	s5upper = tile_map.get_cell_tile_data(1, upper)
	
	if s1center:
		var s1breakable = s1center.get_custom_data(is_breakable)
		if s1breakable:
			tile_map.erase_cell(1, center)
		
	if s2left:
		var s2breakable = s2left.get_custom_data(is_breakable)
		if s2breakable:
			tile_map.erase_cell(1, left)
		
	if s3right:
		var s3breakable = s3right.get_custom_data(is_breakable)
		if s3breakable:
			tile_map.erase_cell(1, right)
		
	if s4down:
		var s4breakable = s4down.get_custom_data(is_breakable)
		if s4breakable:
			tile_map.erase_cell(1, down)
		
	if s5upper:
		var s5breakable = s5upper.get_custom_data(is_breakable)
		if s5breakable:
			tile_map.erase_cell(1, upper)
	
	
	bomb_hit = true
		
	
	
func tile_data(tilemap : TileMap, ground_layer :int, character_position: Vector2i):
	return tilemap.get_cell_tile_data(ground_layer, character_position)
