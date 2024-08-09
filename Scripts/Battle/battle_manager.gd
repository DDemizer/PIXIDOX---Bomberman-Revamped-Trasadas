extends Node

var build1_active = false
var build2_active = false
var build3_active = false
var build4_active = false

var bomb1_active = true
var bomb2_active = true
var bomb3_active = true
var bomb4_active = true

var running1_avail = true
var running2_avail = true
var running3_avail = true
var running4_avail = true

var player1_stunnable = false
var player2_stunnable = false
var player3_stunnable = false
var player4_stunnable = false

var player1_stunned = false
var player2_stunned = false
var player3_stunned = false
var player4_stunned = false

var player1_stun_bonus = 0
var player2_stun_bonus = 0
var player3_stun_bonus = 0
var player4_stun_bonus = 0

var punch1_active
var punch2_active
var punch3_active
var punch4_active



signal build1_activated_to_BUI
signal build2_activated_to_BUI
signal build3_activated_to_BUI
signal build4_activated_to_BUI
signal punch1_activated_to_BUI
signal punch2_activated_to_BUI
signal punch3_activated_to_BUI
signal punch4_activated_to_BUI
signal bomb1_activated_to_BUI
signal bomb2_activated_to_BUI
signal bomb3_activated_to_BUI
signal bomb4_activated_to_BUI

signal paused
#signal running

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func on_build1_activated():
	emit_signal('build1_activated_to_BUI')
	
func on_build2_activated():
	emit_signal('build2_activated_to_BUI')
	
func on_build3_activated():
	emit_signal('build3_activated_to_BUI')
	
func on_build4_activated():
	emit_signal('build4_activated_to_BUI')
	
func on_punch1_activated():
	emit_signal('punch1_activated_to_BUI')
	
func on_punch2_activated():
	emit_signal('punch2_activated_to_BUI')
	
func on_punch3_activated():
	emit_signal('punch3_activated_to_BUI')
	
func on_punch4_activated():
	emit_signal('punch4_activated_to_BUI')
	
func on_bomb1_activated():
	emit_signal('bomb1_activated_to_BUI')

func on_bomb2_activated():
	emit_signal('bomb2_activated_to_BUI')

func on_bomb3_activated():
	emit_signal('bomb3_activated_to_BUI')
	
func on_bomb4_activated():
	emit_signal('bomb4_activated_to_BUI')
	
func on_pause():
	emit_signal('paused')
	
#func on_run():
#	emit_signal('running')
