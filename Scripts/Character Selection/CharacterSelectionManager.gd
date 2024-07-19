extends Node

var players_in_game = 0
var players_ready = 0

var player1_ready = false
var player2_ready = false
var player3_ready = false
var player4_ready = false

var player1
var player2
var player3
var player4

var characters = {
	'raccoon' : preload("res://character-scenes/raccoon.tscn"),
	'cat' : preload("res://character-scenes/raccoon.tscn"),
	'beaver' : preload("res://character-scenes/raccoon.tscn"),
	'monkey' : preload("res://character-scenes/raccoon.tscn")
}


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
