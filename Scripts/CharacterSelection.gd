extends Sprite2D

var characters = []
var playerNumber

# Activated
var player1Activated = false
var player2Activated = false
var player3Activated = false
var player4Activated = false

# Integers
const CURSOR_SPEED = 100
var currentSelected = 0
var currentColumnSpot = 0
var currentRowSpot = 0
var numberOfPlayers = 0

# Exports 
@export var player1Text: Texture
@export var player2Text: Texture
@export var player3Text: Texture
@export var player4Text: Texture
@export var amountOfRows: int = 0
@export var portraitOffset: Vector2

@onready var gridContainer = get_parent().get_node('GridContainer')
@onready var parent = get_parent()



# Called when the node enters the scene tree for the first time.
func _ready():
	for nameOfCharacter in get_tree().get_nodes_in_group('Character'):
		characters.append(nameOfCharacter)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Debugging
	if Input.is_action_just_pressed('debug'):
		print_debug(parent)
		print_debug(parent.player1Activated)
		print_debug(parent.player2Activated)
		print_debug(parent.player3Activated)
		print_debug(parent.player4Activated)
		print_debug(parent.playerCountLeft)
		
	
	
	# Activation
	var playerActivate = Input.is_action_just_pressed('general_start_button') # temporary for Second Option
	var player1Activate = Input.is_action_just_pressed('player1_start_button')
	var player2Activate = Input.is_action_just_pressed('player2_start_button')
	var player3Activate = Input.is_action_just_pressed('player3_start_button')
	var player4Activate = Input.is_action_just_pressed('player4_start_button')
	
	# Controls
	var up1 = Input.is_action_just_pressed('up_player1')
	var down1 = Input.is_action_just_pressed('down_player1')
	var right1 = Input.is_action_just_pressed('right_player1')
	var left1 = Input.is_action_just_pressed('left_player1')
	
	# Second Option
#	if playerActivate:
#		if playerNumber == null:
#			playerNumber = parent.players.pop_front()
#
#	if playerNumber == 1:
#		parent.player1Activated = true
#		if player1Activate:
#			parent.players.append(playerNumber)
#			playerNumber = null
#	elif playerNumber == 2:
#		parent.player2Activated = true
#		if player2Activate:
#			parent.players.append(playerNumber)
#			playerNumber = null
#	elif playerNumber == 3:
#		parent.player3Activated = true
#		if player3Activate:
#			parent.players.append(playerNumber)
#			playerNumber = null
#	elif playerNumber == 4:
#		parent.player4Activated = true
#		if player4Activate:
#			parent.players.append(playerNumber)
#			playerNumber = null
		
	# Main Option
#	if player1Activate:
#		if parent.player1Activated == false and playerNumber == null:
#			parent.player1Activated = true
#			playerNumber = 1
#		elif playerNumber == 1:
#			playerNumber = null
#			parent.player1Activated = false
#	if player2Activate:
#		if parent.player2Activated == false and playerNumber == null:
#			parent.player2Activated = true
#			playerNumber = 2
#		elif playerNumber == 2:
#			playerNumber = null
#			parent.player2Activated = false
#	if player3Activate:
#		if parent.player3Activated == false and playerNumber == null:
#			parent.player3Activated = true
#			playerNumber = 3
#		elif playerNumber == 3:
#			playerNumber = null
#			parent.player3Activated = false
#	if player4Activate:
#		if parent.player4Activated == false and playerNumber == null:
#			parent.player4Activated = true
#			playerNumber = 4
#		elif playerNumber == 4:
#			playerNumber = null
#			parent.player4Activated = false
#
#	if playerNumber == 1:
#		texture = player1Text
#	elif playerNumber == 2:
#		texture = player2Text
#	elif playerNumber == 3:
#		texture = player3Text
#	elif playerNumber == 4:
#		texture = player4Text
#	elif playerNumber == null:
#		texture = null
#
