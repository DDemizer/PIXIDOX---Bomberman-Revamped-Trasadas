extends Node

var build1_active = false
var build2_active = false
var build3_active = false
var build4_active = false

signal build1_activated_to_BUI
signal build2_activated_to_BUI
signal build3_activated_to_BUI
signal build4_activated_to_BUI

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
