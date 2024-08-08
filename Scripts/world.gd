extends Node2D

var player1
var player2
var player3
var player4

# Called when the node enters the scene tree for the first time.
func _ready(): 
	if CharacterSelectionManager.player1 != null:
		player1 = CharacterSelectionManager.player1.instantiate()
	if CharacterSelectionManager.player2 != null:
		player2= CharacterSelectionManager.player2.instantiate()
	if CharacterSelectionManager.player3 != null:
		player3 = CharacterSelectionManager.player3.instantiate()
	if CharacterSelectionManager.player4 != null:
		player4 = CharacterSelectionManager.player4.instantiate()
	SpawnCharacters()

func SpawnCharacters():
	print_debug(player1)
	# Player 1 Position
	if player1 != null:
		player1.position.x = 514
		player1.position.y = 96
#		player1.player = 0
		call_deferred("add_child", player1)
		print_debug('Player 1 Controller: ', player1.player)
		
		
	# Player 2 Position
	if player2 != null:
		player2.position.x = 1407 
		player2.position.y = 96
		player2.player = 1
		call_deferred("add_child", player2)
		print_debug('Player 2 Controller: ', player2.player)
#
#	# Player 3 Position
	if player3 != null: 
		player3.position.x = 514 
		player3.position.y = 986
		player3.player = 2
		call_deferred("add_child", player3)
		print_debug('Player 3 Controller: ', player3.player)
#
#	# Player 4 Position
	if player4 != null: 
		player4.position.x = 1407
		player4.position.y = 986
		player4.player = 3
		call_deferred("add_child", player4) 
		print_debug('Player 4 Controller: ', player4.player)
#

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
