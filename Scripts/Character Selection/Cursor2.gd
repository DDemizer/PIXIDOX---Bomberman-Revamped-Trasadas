extends Sprite2D

const SPEED = 5

var cursor_on_raccoon = false
var cursor_on_cat = false
var cursor_on_beaver = false
var cursor_on_monkey = false

@onready var player2_character = $"../Player 2"

@onready var parent = get_parent()

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

func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Cursor Movement
	if Input.is_joy_button_pressed(player, up):
		position.y += -SPEED
	if Input.is_joy_button_pressed(player, down):
		position.y += SPEED
	if Input.is_joy_button_pressed(player, left):
		position.x += -SPEED
	if Input.is_joy_button_pressed(player, right):
		position.x += SPEED
		
#	if Input.is_joy_button_pressed(player, red):
#		process_mode = 0
#		CharacterSelectionManager.players_ready -= 1

	if cursor_on_raccoon:
		player2_character.texture = parent.raccoon_character_hovered_texture
		if Input.is_joy_button_pressed(player, yellow):
			process_mode = 4
			CharacterSelectionManager.players_ready += 1
			CharacterSelectionManager.player2_ready = true
			CharacterSelectionManager.player2 = CharacterSelectionManager.characters['raccoon']
			player2_character.texture = parent.raccoon_character_picked_texture
	
		
	if cursor_on_cat:
		player2_character.texture = parent.cat_character_hovered_texture
		if Input.is_joy_button_pressed(player, yellow):
			process_mode = 4
			CharacterSelectionManager.players_ready += 1
			CharacterSelectionManager.player2_ready = true
			CharacterSelectionManager.player2 = CharacterSelectionManager.characters['cat']
			player2_character.texture = parent.cat_character_picked_texture
	
		
	if cursor_on_beaver:
		player2_character.texture = parent.beaver_character_hovered_texture
		if Input.is_joy_button_pressed(player, yellow):
			process_mode = 4
			CharacterSelectionManager.players_ready += 1
			CharacterSelectionManager.player2_ready = true
			CharacterSelectionManager.player2 = CharacterSelectionManager.characters['beaver']
			player2_character.texture = parent.beaver_character_picked_texture

		
	if cursor_on_monkey:
		player2_character.texture = parent.monkey_character_hovered_texture
		if Input.is_joy_button_pressed(player, yellow):
			process_mode = 4
			CharacterSelectionManager.players_ready += 1
			CharacterSelectionManager.player2_ready = true
			CharacterSelectionManager.player2 = CharacterSelectionManager.characters['monkey']
			player2_character.texture = parent.monkey_character_picked_texture
			
	if cursor_on_raccoon == false and cursor_on_cat == false and cursor_on_beaver == false and cursor_on_monkey == false: 
		player2_character.texture = null


func _on_raccoon_area_entered(area):
	cursor_on_raccoon = true
	print_debug(cursor_on_raccoon)
	
func _on_cat_area_entered(area):
	cursor_on_cat = true
	print_debug(cursor_on_cat)
	
func _on_beaver_area_entered(area):
	cursor_on_beaver = true
	print_debug(cursor_on_beaver)
	
func _on_monkey_area_entered(area):
	cursor_on_monkey = true
	print_debug(cursor_on_monkey)

func _on_raccoon_area_exited(area):
	cursor_on_raccoon = false
	print_debug(cursor_on_raccoon)

func _on_cat_area_exited(area):
	cursor_on_cat = false
	print_debug(cursor_on_cat)

func _on_beaver_area_exited(area):
	cursor_on_beaver = false
	print_debug(cursor_on_beaver)

func _on_monkey_area_exited(area):
	cursor_on_monkey = false
	print_debug(cursor_on_monkey)
