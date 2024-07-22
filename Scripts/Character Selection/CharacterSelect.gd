extends Sprite2D

const SPEED = 10

@onready var cursor_1 = $"."
@onready var cursor_2 = $"../Cursor2"
@onready var cursor_3 = $"../Cursor3"
@onready var cursor_4 = $"../Cursor4"
var cursor1_on_card = false
var cursor2_on_card = false
var cursor3_on_card = false
var cursor4_on_card = false
#var cursor1_ready = false
#var cursor2_ready = false
#var cursor3_ready = false
#var cursor4_ready = false

var player

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
	# Players for Cursor
#	if self == cursor_1:
#		player = 0
#	if self == cursor_2:
#		player = 1
#	if self == cursor_3:
#		player = 2
#	if self == cursor_4:
#		player = 3
#
#	print_debug(cursor_1 == cursor_4)
#	print_debug(self)
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

	if Input.is_joy_button_pressed(player, yellow):
		process_mode = 4
		CharacterSelectionManager.players_ready += 1
	if Input.is_action_just_pressed('cancel'):
		process_mode = 0
		CharacterSelectionManager.players_ready = 0


func _on_raccoon_area_entered(area):
	if self == cursor_1:
		CharacterSelectionManager.player1 = CharacterSelectionManager.characters['raccoon']
		cursor1_on_card = true
		print_debug('Cursor 1 inside Raccoon')
		print_debug(self)
	elif self == cursor_2:
		CharacterSelectionManager.player2 = CharacterSelectionManager.characters['raccoon']
		cursor2_on_card = true
		print_debug('Cursor 2 inside Raccoon')
	elif self == cursor_3:
		CharacterSelectionManager.player3 = CharacterSelectionManager.characters['raccoon']
		cursor3_on_card = true
		print_debug('Cursor 3 inside Raccoon')
	elif self == cursor_4:
		CharacterSelectionManager.player4 = CharacterSelectionManager.characters['raccoon']
		cursor4_on_card = true
		print_debug('Cursor 4 inside Raccoon')

func _on_cat_area_entered(area):
	if self == cursor_1:
		CharacterSelectionManager.player1 = CharacterSelectionManager.characters['cat']
		cursor1_on_card = true
	if self == cursor_2:
		CharacterSelectionManager.player2 = CharacterSelectionManager.characters['cat']
		cursor2_on_card = true
	if self == cursor_3:
		CharacterSelectionManager.player3 = CharacterSelectionManager.characters['cat']
		cursor3_on_card = true
	if self == cursor_4:
		CharacterSelectionManager.player4 = CharacterSelectionManager.characters['cat']
		cursor4_on_card = true

func _on_beaver_area_entered(area):
	if self == cursor_1:
		CharacterSelectionManager.player1 = CharacterSelectionManager.characters['beaver']
		cursor1_on_card = true
	if self == cursor_2:
		CharacterSelectionManager.player2 = CharacterSelectionManager.characters['beaver']
		cursor2_on_card = true
	if self == cursor_3:
		CharacterSelectionManager.player3 = CharacterSelectionManager.characters['beaver']
		cursor3_on_card = true
	if self == cursor_4:
		CharacterSelectionManager.player4 = CharacterSelectionManager.characters['beaver']
		cursor4_on_card = true

func _on_monkey_area_entered(area):
	if self == cursor_1:
		CharacterSelectionManager.player1 = CharacterSelectionManager.characters['monkey']
		cursor1_on_card = true
	if self == cursor_2:
		CharacterSelectionManager.player2 = CharacterSelectionManager.characters['monkey']
		cursor2_on_card = true
	if self == cursor_3:
		CharacterSelectionManager.player3 = CharacterSelectionManager.characters['monkey']
		cursor3_on_card = true
	if self == cursor_4:
		CharacterSelectionManager.player4 = CharacterSelectionManager.characters['monkey']
		cursor4_on_card = true
		

