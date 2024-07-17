extends Control

@export var player1Activated = false
@export var player2Activated = false
@export var player3Activated = false
@export var player4Activated = false
@export var players = [1, 2, 3, 4]
var playerCountLeft = players.size()
var playerNumber

@onready var cursor1 = $Cursor1
@onready var cursor2 = $Cursor2
@onready var cursor3 = $Cursor3
@onready var cursor4 = $Cursor4



# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
#	print_debug(playerCountLeft)
	var playerActivate = Input.is_action_just_pressed('general_start_button') # temporary for Second Option
	if playerActivate:
		playerNumber = players.pop_front()
	
	#Cursor Activation
	if playerCountLeft != 0:
		if player1Activated:
			cursor1.process_mode = 4
			cursor2.process_mode = 0
			cursor2.process_mode = 4
			cursor2.process_mode = 4
		elif player2Activated:
			cursor1.process_mode = 4
			cursor2.process_mode = 4
			cursor2.process_mode = 0
			cursor2.process_mode = 4
		elif player3Activated:
			cursor1.process_mode = 4
			cursor2.process_mode = 4
			cursor2.process_mode = 4
			cursor2.process_mode = 0
		elif player4Activated:
			cursor1.process_mode = 0
			cursor2.process_mode = 4
			cursor2.process_mode = 4
			cursor2.process_mode = 4
			
	
