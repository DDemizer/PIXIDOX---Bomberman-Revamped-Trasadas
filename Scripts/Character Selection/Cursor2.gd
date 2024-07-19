extends Sprite2D

const SPEED = 10

var cursor_on_raccoon = false
var cursor_on_cat = false
var cursor_on_beaver = false
var cursor_on_monkey = false


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

	if Input.is_joy_button_pressed(player, yellow):
		process_mode = 4
		CharacterSelectionManager.players_ready += 1
		CharacterSelectionManager.player2_ready = true
		if cursor_on_raccoon:
			CharacterSelectionManager.player2 = CharacterSelectionManager.characters['raccoon']
		if cursor_on_cat:
			CharacterSelectionManager.player2 = CharacterSelectionManager.characters['cat']
		if cursor_on_beaver:
			CharacterSelectionManager.player2 = CharacterSelectionManager.characters['beaver']
		if cursor_on_monkey:
			CharacterSelectionManager.player2 = CharacterSelectionManager.characters['monkey']


func _on_raccoon_area_entered(area):
	cursor_on_raccoon = true

func _on_cat_area_entered(area):
	cursor_on_cat = true
	
func _on_beaver_area_entered(area):
	cursor_on_beaver = true
	
func _on_monkey_area_entered(area):
	cursor_on_monkey = true
