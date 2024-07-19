extends Node2D

@onready var player1 = CharacterSelectionManager.player1
#@onready var player2 = CharacterSelectionManager.player2.instantiate()
#@onready var player3 = CharacterSelectionManager.player3.instantiate()
#@onready var player4 = CharacterSelectionManager.player4.instantiate()


# Called when the node enters the scene tree for the first time.
func _ready():
	SpawnCharacters()

func SpawnCharacters():
	# Player 1 Position
	if player1 != null:
		player1.position.x = 514
		player1.position.y = 96
		call_deferred("add_child", player1)
	
	# Player 2 Position
#	if player2 != null:	
#		player2.position.x = 1407
#		player2.position.y = 96
#		call_deferred("add_child", player2)
#
#	# Player 3 Position
#	if player3 != null:
#		player3.position.x = 514
#		player3.position.y = 986
#		call_deferred("add_child", player3)
#
#	# Player 4 Position
#	if player4 != null:
#		player4.position.x = 1407
#		player4.position.y = 986
#		call_deferred("add_child", player4)
#

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
