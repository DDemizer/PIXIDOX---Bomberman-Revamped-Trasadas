extends CharacterBody2D

const SPEED = 70
var speed_multiplier = 1
var character_speed_addition = 0
var character_bomb_addition = 0

#const JUMP_VELOCITY = -400.0
# NODES
@onready var animation = get_node("AnimationPlayer")
@onready var sprite = $AnimatedSprite2D
@onready var down_punch = $Down/DownPunch
@onready var down_punch_sprite = $Down/DownPunchSprite
@onready var up_punch = $Up/UpPunch
@onready var up_punch_sprite = $Up/UpPunchSprite
@onready var left_punch = $Left/LeftPunch
@onready var left_punch_sprite = $Left/LeftPunchSprite
@onready var right_punch = $Right/RightPunch
@onready var right_punch_sprite = $Right/RightPunchSprite

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

# Direction Facing
var facing = 'down'

#@onready var parent = get_parent()
@onready var tile_map = $"../Map"
@onready var bomb = $"../Bomb"
@onready var pause_menu = $'../PauseMenu'
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

# game mode
var gamemode

# bomb
var bomb_level : int = 1
var current_anim : Vector2i
var bomb_explode = false
var is_breakable = 'breakable'
var is_unbreakable = 'unbreakable'
var s1center : TileData
var s2left : TileData
var s3right : TileData
var s4down : TileData
var s5upper : TileData
var s1breakable
var s2breakable
var s3breakable
var s4breakable
var s5breakable
var left_collision = true
var right_collision = true
var upper_collision = true
var down_collision = true
signal bomba_placed 
var bomb_range = []
var center : Vector2i
var explode = false



# power up
var chance
var power_up_pos = []
var char_par_pos
var character_power_position
var power_index



# punching
var player_inside
var stunned = false
var monkey_bonus
var stun_added = 0

signal build1_activated
signal build2_activated
signal build3_activated
signal build4_activated
signal punch1_activated
signal punch2_activated
signal punch3_activated
signal punch4_activated
signal bomb1_activated
signal bomb2_activated
signal bomb3_activated
signal bomb4_activated
signal bomb1_pressed
signal bomb2_pressed
signal bomb3_pressed
signal bomb4_pressed
signal pause
#signal running

func _ready():
	connect('build1_activated', BattleManager.on_build1_activated)
	connect('build2_activated', BattleManager.on_build2_activated)
	connect('build3_activated', BattleManager.on_build3_activated)
	connect('build4_activated', BattleManager.on_build4_activated)
	connect('punch1_activated', BattleManager.on_punch1_activated)
	connect('punch2_activated', BattleManager.on_punch2_activated)
	connect('punch3_activated', BattleManager.on_punch3_activated)
	connect('punch4_activated', BattleManager.on_punch4_activated)
	connect('bomb1_activated', BattleManager.on_bomb1_activated)
	connect('bomb2_activated', BattleManager.on_bomb2_activated)
	connect('bomb3_activated', BattleManager.on_bomb3_activated)
	connect('bomb4_activated', BattleManager.on_bomb4_activated)
	connect('pause', BattleManager.on_pause)
#	connect('running', BattleManager.on_run)

	# Special Feature for Characters
	if self.name == "Raccoon":
		character_bomb_addition = 1
	if self.name == "Cat":
		character_speed_addition = 0.2
	if self.name == 'Monkey':
		monkey_bonus = true

func _physics_process(delta):
	# Debug
	if Input.is_action_just_pressed("debug"):
		print_debug(BattleManager.player1_stunnable)
		print_debug(BattleManager.player2_stunnable)
		print_debug(BattleManager.player3_stunnable)
		print_debug(BattleManager.player4_stunnable)
		print_debug(BattleManager.player1_stunned)
		print_debug(BattleManager.player2_stunned)
		print_debug(BattleManager.player3_stunned)
		print_debug(BattleManager.player4_stunned)
		print_debug(player_inside)
	
	# buttons
	var up_button = Input.is_joy_button_pressed(player, up)
	var down_button = Input.is_joy_button_pressed(player, down)
	var right_button = Input.is_joy_button_pressed(player, right)
	var left_button = Input.is_joy_button_pressed(player, left)
	var escape = Input.is_action_just_pressed('ui_cancel')
	# WALKING
	if up_button or down_button:
		if up_button:
			velocity.y = -SPEED * speed_multiplier
			if not right_button and not left_button:
				animation.play('up')
				facing = 'up'
		if down_button:
			velocity.y = SPEED * speed_multiplier
			if not right_button and not left_button:
				animation.play('down')
				facing = 'down'
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)
		
	if right_button or left_button:
		if right_button or (right_button and up_button) or (right_button and down_button):
			sprite.flip_h = false
			animation.play('side')
			facing = 'right'
			velocity.x = SPEED * speed_multiplier
		if left_button or (left_button and up_button) or (left_button and down_button):
			sprite.flip_h = true
			animation.play('side')
			facing = 'left'
			velocity.x = -SPEED * speed_multiplier
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		sprite.flip_h = false
#	
	if not (up_button or down_button or left_button or right_button):
		animation.play('idle')
		facing = 'down'
		
	# PUNCHING
	if Input.is_joy_button_pressed(player, red):
		if player == 0 and BattleManager.punch1_active:
			emit_signal('punch1_activated')
			BattleManager.punch1_active = false
			punch()
			
		if player == 1 and BattleManager.punch2_active:
			emit_signal('punch2_activated')
			BattleManager.punch2_active = false
			punch()
			
		if player == 2 and BattleManager.punch3_active:
			emit_signal('punch_activated')
			BattleManager.punch3_active = false
			punch()
			
		if player == 3 and BattleManager.punch4_active:
			emit_signal('punch4_activated')
			BattleManager.punch4_active = false
			punch()
			
			
		if player_inside == 0:
			BattleManager.player1_stunned = true
			if monkey_bonus:
				BattleManager.player1_stun_bonus = 2
				
		if player_inside == 1:
			BattleManager.player2_stunned = true
			if monkey_bonus:
				BattleManager.player2_stun_bonus = 2
		if player_inside == 2:
			BattleManager.player3_stunned = true
			if monkey_bonus:
				BattleManager.player3_stun_bonus = 2
		if player_inside == 3:
			BattleManager.player4_stunned = true
			if monkey_bonus:
				BattleManager.player4_stun_bonus = 2
			
	if player == 0 and BattleManager.player1_stunned:
		self.process_mode = 4
		await get_tree().create_timer(2 + BattleManager.player1_stun_bonus).timeout
		self.process_mode = 0
		BattleManager.player1_stunned = false
		BattleManager.player1_stun_bonus = 0
	if player == 1 and BattleManager.player2_stunned:
		self.process_mode = 4
		await get_tree().create_timer(2 + BattleManager.player2_stun_bonus).timeout
		self.process_mode = 0
		BattleManager.player2_stunned = false
		BattleManager.player2_stun_bonus = 0
	if player == 2 and BattleManager.player3_stunned:
		self.process_mode = 4
		await get_tree().create_timer(2 + BattleManager.player3_stun_bonus).timeout
		self.process_mode = 0
		BattleManager.player3_stunned = false
		BattleManager.player3_stun_bonus = 0
	if player == 3 and BattleManager.player4_stunned:
		self.process_mode = 4
		await get_tree().create_timer(2 + BattleManager.player4_stun_bonus).timeout
		self.process_mode = 0
		BattleManager.player4_stunned = false
		BattleManager.player4_stun_bonus = 0
		
		
	# RUNNING
	if Input.is_joy_button_pressed(player,l1):
		if player == 0:
			if BattleManager.running1_avail:
				$'../BattleUI'.running1_active = true
				speed_multiplier = 2 + character_speed_addition
			else:
				$'../BattleUI'.running1_active = false
				speed_multiplier = 1 + character_speed_addition
		if player == 1:
			if BattleManager.running2_avail:
				$'../BattleUI'.running2_active = true
				speed_multiplier = 2 + character_speed_addition
			else:
				$'../BattleUI'.running2_active = false
				speed_multiplier = 1 + character_speed_addition
		if player == 2:
			if BattleManager.running3_avail:
				$'../BattleUI'.running3_active = true
				speed_multiplier = 2 + character_speed_addition
			else:
				$'../BattleUI'.running3_active = false
				speed_multiplier = 1 + character_speed_addition
		if player == 3:
			if BattleManager.running4_avail:
				$'../BattleUI'.running4_active = true
				speed_multiplier = 2 + character_speed_addition
			else:
				$'../BattleUI'.running4_active = false
				speed_multiplier = 1 + character_speed_addition
	else:
		speed_multiplier = 1 + character_speed_addition
		if player == 0:
			$'../BattleUI'.running1_active = false
		if player == 1:
			$'../BattleUI'.running2_active = false
		if player == 2:
			$'../BattleUI'.running3_active = false
		if player == 3:
			$'../BattleUI'.running4_active = false
		
		
	# SHOULD BE FOR PAUSING
	if Input.is_joy_button_pressed(player, start_button):
		emit_signal('pause')
		pause_menu.show()
	move_and_slide()

func _process(delta):
	if placed_block == true:
		char_pos = self.global_position
		character_Position = tile_map.local_to_map(char_pos)
		if character_Position != charToTileMapPosition:
			tile_map.set_cell(sand, charToTileMapPosition, source_id_Wphysics, atlastCoords)
			placed_block = false
	char_par_pos = self.global_position
	character_power_position = tile_map.local_to_map(char_par_pos)
	
	if character_power_position in power_up_pos:
		tile_map.erase_cell(1, character_power_position)
		for i in power_up_pos:
			power_index = -1
			if i == character_Position:
				break
			else:
				power_index += 1
		power_up_pos.pop_at(power_index)
		power_index = 0
		$PowerUpSound.play()
		if bomb_level < 5:
			bomb_level += 1
		
		
		
			
#	
	


func _input(event):
	#BUILDING
	if Input.is_joy_button_pressed(player, blue):
		if player == 0 and BattleManager.build1_active:
			place_block()
			BattleManager.build1_active = false
			emit_signal('build1_activated')
		if player == 1 and BattleManager.build2_active:
			place_block()
			BattleManager.build2_active = false
			emit_signal('build2_activated')
		if player == 2 and BattleManager.build3_active:
			place_block()
			BattleManager.build3_active = false
			emit_signal('build3_activated')
		if player == 3 and BattleManager.build4_active:
			place_block()
			BattleManager.build4_active = false
			emit_signal('build4_activated')
		
	if Input.is_joy_button_pressed(player, green):
		if player == 0 and BattleManager.bomb1_active:
			place_bomb()
			BattleManager.bomb1_active = false
			emit_signal('bomb1_activated')
			emit_signal('bomb1_pressed')
		if player == 1 and BattleManager.bomb2_active:
			place_bomb()
			BattleManager.bomb2_active = false
			emit_signal('bomb2_activated')
			emit_signal('bomb2_pressed')
		if player == 2 and BattleManager.bomb3_active:
			place_bomb()
			BattleManager.bomb3_active = false
			emit_signal('bomb3_activated')
			emit_signal('bomb3_pressed')
		if player == 3 and BattleManager.bomb4_active:
			place_bomb()
			BattleManager.bomb4_active = false
			emit_signal('bomb4_activated')
			emit_signal('bomb4_pressed')
			
func place_bomb():
#position of the character
	
	character = self.global_position
	
	#position coords
	charToTileMapPosition = bomb.local_to_map(character)
	placed_bomb = true
	#place the bomb
#		if tile_data(tile_map, sand, charToTileMapPosition) == true:
	var xx : TileData = tile_map.get_cell_tile_data(0, charToTileMapPosition)
#	bomb.set_cell(2 ,charToTileMapPosition, bombId_WOphysics, atlastCoordsBomb)
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
	
func punch():
	if facing == 'down':
		down_punch_sprite.show()
		down_punch.play("down")
		await get_tree().create_timer(0.5).timeout
		down_punch_sprite.hide()
		
	elif facing == 'up':
		up_punch_sprite.show()
		up_punch.play("up")
		await get_tree().create_timer(0.5).timeout
		up_punch_sprite.hide()
		
	elif facing == 'right':
		right_punch_sprite.show()
		right_punch.play("right")
		await get_tree().create_timer(0.5).timeout
		right_punch_sprite.hide()
		
	elif facing == 'left':
		left_punch_sprite.show()
		left_punch.play("left")
		await get_tree().create_timer(0.5).timeout
		left_punch_sprite.hide()


func bomb_handler(bomb_position):     
	
	var bombs = Vector2i(bomb_position.x, bomb_position.y)
	emit_signal('bomba_placed')
	await get_tree().create_timer(1.5).timeout
	placed_bomb = false
	explode = true
	bomb_explosion(bomb_position, bomb_level)
	bomb.erase_cell(0, bombs)
	
	current_anim = atlastCoordsBomb
	
		
func bomb_explosion(bomb_position, bomb_level: int):
	center = bomb_position
	var upper :Vector2i = Vector2i(center.x, center.y - 1)
	var left : Vector2i = Vector2i(center.x - 1, center.y)
	var right : Vector2i = Vector2i(center.x + 1, center.y)
	var down : Vector2i = Vector2i(center.x, center.y + 1)
	
	
	s1center = tile_map.get_cell_tile_data(1, center)
	s2left = tile_map.get_cell_tile_data(1, left)
	s3right = tile_map.get_cell_tile_data(1, right)
	s4down = tile_map.get_cell_tile_data(1, down)
	s5upper = tile_map.get_cell_tile_data(1, upper)
	
	
	gamemode = 0
	
	
	if gamemode == 0:
		if s1center:
			s1breakable = s1center.get_custom_data(is_breakable)
			if s1breakable:
				tile_map.erase_cell(1, center)
				
		for i in bomb_level:
			
			left = Vector2i(center.x - (1 + i), center.y)
			s2left = tile_map.get_cell_tile_data(1, left)
			if s2left:
				s2breakable = s2left.get_custom_data(is_breakable)
				if s2breakable:
					tile_map.erase_cell(1, left)
					chance = randi() % 100
					if chance < 18:
						tile_map.set_cell(1, left, 5, Vector2i(0,0))
						power_up_pos.append(left)
					break

				else:
					s2breakable = s2left.get_custom_data(is_unbreakable)
					if s2breakable:
						break
			
		for i in bomb_level:
			
			right = Vector2i(center.x + (1 + i), center.y)
			s3right = tile_map.get_cell_tile_data(1, right)
			if s3right:
				s3breakable = s3right.get_custom_data(is_breakable)
				if s3breakable:
					tile_map.erase_cell(1, right)
					chance = randi() % 100
					if chance < 18:
						tile_map.set_cell(1, right, 5, Vector2i(0,0))
						power_up_pos.append(right)
					break
				
				else:
					s3breakable = s3right.get_custom_data(is_unbreakable)
					if s3breakable:
						break
				
		for i in bomb_level:
			
			down = Vector2i(center.x , center.y + (1 + i))
			s4down = tile_map.get_cell_tile_data(1, down)
			if s4down:
				s4breakable = s4down.get_custom_data(is_breakable)
				if s4breakable:
					tile_map.erase_cell(1, down)
					chance = randi() % 100
					if chance < 18:
						tile_map.set_cell(1, down, 5, Vector2i(0,0))
						power_up_pos.append(down)
					break
					
				else:
					s4breakable = s4down.get_custom_data(is_unbreakable)
					if s4breakable:
						break
		
		for i in bomb_level:
			
			upper = Vector2i(center.x , center.y - (1 + i))
			s5upper = tile_map.get_cell_tile_data(1, upper)
			if s5upper:
				s5breakable = s5upper.get_custom_data(is_breakable)
				if s5breakable:
					tile_map.erase_cell(1, upper)
					chance = randi() % 100
					if chance < 18:
						tile_map.set_cell(1, upper, 5, Vector2i(0,0))
						power_up_pos.append(upper)
					break
					
				else:
					s5breakable = s5upper.get_custom_data(is_unbreakable)
					if s5breakable:
						break
		
		explode = false
			
	
	
	if gamemode == 1:
		if s1center:
			s1breakable = s1center.get_custom_data(is_breakable)
			if s1breakable:
				tile_map.erase_cell(1, center)
					
			
		for i in bomb_level:
		
			left = Vector2i(center.x - (1 + i), center.y)
			s2left = tile_map.get_cell_tile_data(1, left)
			if s2left:
				s2breakable = s2left.get_custom_data(is_breakable)
				if s2breakable:
					tile_map.erase_cell(1, left)
					chance = randi() % 100
					if chance < 18:
						tile_map.set_cell(1, left, 5, Vector2i(0,0))
						power_up_pos.append(left)

				else:
					s2breakable = s2left.get_custom_data(is_unbreakable)
					if s2breakable:
						break
		
		for i in bomb_level:
			
			right = Vector2i(center.x + (1 + i), center.y)
			s3right = tile_map.get_cell_tile_data(1, right)
			if s3right:
				s3breakable = s3right.get_custom_data(is_breakable)
				if s3breakable:
					tile_map.erase_cell(1, right)
					chance = randi() % 100
					if chance < 18:
						tile_map.set_cell(1, right, 5, Vector2i(0,0))
						power_up_pos.append(right)
				
				else:
					s3breakable = s3right.get_custom_data(is_unbreakable)
					if s3breakable:
						break
				
		for i in bomb_level:
			
			down = Vector2i(center.x , center.y + 1)
			s4down = tile_map.get_cell_tile_data(1, down)
			if s4down:
				s4breakable = s4down.get_custom_data(is_breakable)
				if s4breakable:
					tile_map.erase_cell(1, down)
					chance = randi() % 100
					if chance < 18:
						tile_map.set_cell(1, down, 5, Vector2i(0,0))
						power_up_pos.append(down)
					
				else:
					s4breakable = s4down.get_custom_data(is_unbreakable)
					if s4breakable:
						break
		
		for i in bomb_level:
			
			upper = Vector2i(center.x , center.y - 1)
			s5upper = tile_map.get_cell_tile_data(1, upper)
			if s5upper:
				s5breakable = s5upper.get_custom_data(is_breakable)
				if s5breakable:
					tile_map.erase_cell(1, upper)
					chance = randi() % 100
					if chance < 18:
						tile_map.set_cell(1, upper, 5, Vector2i(0,0))
						power_up_pos.append(upper)
					
				else:
					s5breakable = s5upper.get_custom_data(is_unbreakable)
					if s5breakable:
						break
		
	bomb_explode = true
	
	
	
func tile_data(tilemap : TileMap, ground_layer :int, character_position: Vector2i):
	return tilemap.get_cell_tile_data(ground_layer, character_position)

#func stun():
#	if player_inside == 0:
#

# PUNCH DETECTING
func player_stunnable():
	if player_inside == 0:
		BattleManager.player1_stunnable = true
	if player_inside == 1:
		BattleManager.player2_stunnable = true
	if player_inside == 2:
		BattleManager.player3_stunnable = true
	if player_inside == 3:
		BattleManager.player4_stunnable = true

func player_unstunnable():
	if player_inside == 0:
		BattleManager.player1_stunnable = false
	if player_inside == 1:
		BattleManager.player2_stunnable = false
	if player_inside == 2:
		BattleManager.player3_stunnable = false
	if player_inside == 3:
		BattleManager.player4_stunnable = false

func _on_down_area_entered(area):
	player_inside = area.get_parent().player
	player_stunnable()
	
func _on_down_area_exited(area):
	player_inside = area.get_parent().player
	player_unstunnable()

func _on_up_area_entered(area):
	player_inside = area.get_parent().player
	player_stunnable()

func _on_up_area_exited(area):
	player_inside = area.get_parent().player
	player_unstunnable()

func _on_left_area_entered(area):
	player_inside = area.get_parent().player
	player_stunnable()

func _on_left_area_exited(area):
	player_inside = area.get_parent().player
	player_unstunnable()

func _on_right_area_entered(area):
	player_inside = area.get_parent().player
	player_stunnable()

func _on_right_area_exited(area):
	player_inside = area.get_parent().player
	player_unstunnable()
