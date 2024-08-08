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

var player1_texture
var player2_texture
var player3_texture
var player4_texture


var characters = {
	'raccoon' : preload("res://Scenes/character-scenes/raccoon.tscn"),
	'cat' : preload("res://Scenes/character-scenes/cat.tscn"),
	'beaver' : preload("res://Scenes/character-scenes/beaver.tscn"),
	'monkey' : preload("res://Scenes/character-scenes/monkey.tscn")
}


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
