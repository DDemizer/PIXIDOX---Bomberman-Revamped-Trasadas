extends Control

@export var player1_texture : Texture
@export var player2_texture : Texture
@export var player3_texture : Texture
@export var player4_texture : Texture

@onready var cursor1 = $Cursor1
@onready var cursor2 = $Cursor2
@onready var cursor3 = $Cursor3
@onready var cursor4 = $Cursor4

@export var player1Activated = false
@export var player2Activated = false
@export var player3Activated = false
@export var player4Activated = false

# Buttons
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
		
	
	if player1Activated == false:
		if Input.is_joy_button_pressed(0, start_button):
			player1Activated = true
			cursor1.process_mode = 0
			cursor1.texture = player1_texture
			CharacterSelectionManager.players_in_game += 1
			print_debug('Player 1 Activated')
	if player2Activated == false:
		if Input.is_joy_button_pressed(1, start_button):
			player2Activated = true
			cursor2.process_mode = 0
			cursor2.texture = player2_texture
			CharacterSelectionManager.players_in_game += 1
			print_debug('Player 2 Activated')
	if player3Activated == false:
		if Input.is_joy_button_pressed(2, start_button):
			player3Activated = true
			cursor3.process_mode = 0
			cursor3.texture = player3_texture
			CharacterSelectionManager.players_in_game += 1
			print_debug('Player 3 Activated')
	if player4Activated == false:
		if Input.is_joy_button_pressed(3, start_button):
			player4Activated = true
			cursor4.process_mode = 0
			cursor4.texture = player4_texture
			CharacterSelectionManager.players_in_game += 1
			print_debug('Player 4 Activated')
			
	if CharacterSelectionManager.players_ready == CharacterSelectionManager.players_in_game:
		$ReadyLabel.show()
		if Input.is_action_just_pressed("general_start_button"):
			get_tree().change_scene_to_file("res://world.tscn")
	else:
		$ReadyLabel.hide()
		
	
