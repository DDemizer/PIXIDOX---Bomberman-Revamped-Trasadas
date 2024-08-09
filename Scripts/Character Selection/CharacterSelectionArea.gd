extends Control

@export var player1_texture : Texture
@export var player2_texture : Texture
@export var player3_texture : Texture
@export var player4_texture : Texture

@export var raccoon_character_hovered_texture: Texture
@export var cat_character_hovered_texture: Texture
@export var beaver_character_hovered_texture: Texture
@export var monkey_character_hovered_texture: Texture

@export var raccoon_character_picked_texture: Texture
@export var cat_character_picked_texture: Texture
@export var beaver_character_picked_texture: Texture
@export var monkey_character_picked_texture: Texture

@onready var cursor1 = $Cursor1
@onready var cursor2 = $Cursor2
@onready var cursor3 = $Cursor3
@onready var cursor4 = $Cursor4

@onready var raccoon_anim = $GridContainer/RaccoonCard/RaccoonAnim
@onready var cat_anim = $GridContainer/CatCard/CatAnim
@onready var beaver_anim = $GridContainer/BeaverCard/BeaverAnim
@onready var monkey_anim = $GridContainer/MonkeyCard/MonkeyAnim

@export var player1Activated = false
@export var player2Activated = false
@export var player3Activated = false
@export var player4Activated = false

# Maps
var maps = [ 'beach']
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

# Called when the node enters the scene tree for the first time.
func _ready():
	cursor1.process_mode = 4
	cursor2.process_mode = 4
	cursor3.process_mode = 4
	cursor4.process_mode = 4


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# debugging
	if Input.is_action_just_pressed('debug'):
		print_debug('Player 1 Active: ', player1Activated)
		print_debug('Player 2 Active: ', player2Activated)
		print_debug('Player 3 Active: ', player3Activated)
		print_debug('Player 4 Active: ', player4Activated)
		print_debug('Player 1 Character: ', CharacterSelectionManager.player1)
		print_debug('Player 2 Character: ', CharacterSelectionManager.player2)
		print_debug('Player 3 Character: ', CharacterSelectionManager.player3)
		print_debug('Player 4 Character: ', CharacterSelectionManager.player4)
		print_debug('Players Ready: ', CharacterSelectionManager.players_ready)
		print_debug('Players In Game: ', CharacterSelectionManager.players_in_game)

	if player1Activated == false and CharacterSelectionManager.players_ready == CharacterSelectionManager.players_in_game:
		if Input.is_joy_button_pressed(0, start_button):
			player1Activated = true
			cursor1.process_mode = 0
			cursor1.texture = player1_texture
			CharacterSelectionManager.players_in_game += 1
			print_debug('Player 1 Activated')
	if CharacterSelectionManager.player1_ready:
		if Input.is_joy_button_pressed(0, red):
			cursor1.process_mode = 0
			CharacterSelectionManager.players_ready -= 1
			CharacterSelectionManager.player1_ready = false
	
	if player2Activated == false and CharacterSelectionManager.players_ready == CharacterSelectionManager.players_in_game:
		if Input.is_joy_button_pressed(1, start_button):
			player2Activated = true
			cursor2.process_mode = 0
			cursor2.texture = player2_texture
			CharacterSelectionManager.players_in_game += 1
			print_debug('Player 2 Activated')
	if CharacterSelectionManager.player2_ready:
		if Input.is_joy_button_pressed(1, red):
			cursor2.process_mode = 0
			CharacterSelectionManager.players_ready -= 1
			CharacterSelectionManager.player2_ready = false
		
	if player3Activated == false and CharacterSelectionManager.players_ready == CharacterSelectionManager.players_in_game:
		if Input.is_joy_button_pressed(2, start_button):
			player3Activated = true
			cursor3.process_mode = 0
			cursor3.texture = player3_texture
			CharacterSelectionManager.players_in_game += 1
			print_debug('Player 3 Activated')
	if CharacterSelectionManager.player3_ready:
		if Input.is_joy_button_pressed(2, red):
			cursor3.process_mode = 3
			CharacterSelectionManager.players_ready -= 1
			CharacterSelectionManager.player3_ready = false
			
	if player4Activated == false and CharacterSelectionManager.players_ready == CharacterSelectionManager.players_in_game:
		if Input.is_joy_button_pressed(3, start_button):
			player4Activated = true
			cursor4.process_mode = 0
			cursor4.texture = player4_texture
			CharacterSelectionManager.players_in_game += 1
			print_debug('Player 4 Activated')
	if CharacterSelectionManager.player4_ready:
		if Input.is_joy_button_pressed(3, red):
			cursor4.process_mode = 0
			CharacterSelectionManager.players_ready -= 1
			CharacterSelectionManager.player4_ready = false
		
	if Input.is_action_just_pressed("general_select_button"):
		get_tree().change_scene_to_file("res://Scenes/MainMenu.tscn")
		CharacterSelectionManager.players_ready = 0
		CharacterSelectionManager.players_in_game = 0
			
	if  CharacterSelectionManager.players_in_game != 0 and CharacterSelectionManager.players_ready == CharacterSelectionManager.players_in_game:
		$ReadyLabel.text = str(CharacterSelectionManager.players_ready) + ' ' + 'PLAYER/S READY'
		$ReadyLabel.show()
		if Input.is_action_just_pressed("general_start_button"):
			var map_randomizer = maps[randi() % maps.size()]
			await get_tree().create_timer(0.5).timeout
			if map_randomizer == 'desert':
				get_tree().change_scene_to_file("res://maps/desert.tscn")
			elif map_randomizer == 'grassland':
				get_tree().change_scene_to_file("res://maps/grassland.tscn")
			elif map_randomizer == 'beach':
				get_tree().change_scene_to_file("res://maps/beach.tscn")
#			get_tree().change_scene_to_file("res://maps/grassland.tscn")
			CharacterSelectionManager.players_ready = 0
			CharacterSelectionManager.players_in_game = 0
	else:
		$ReadyLabel.hide()
		
	
		
