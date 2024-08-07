extends Control

#@export var p1_text : Texture
#@export var p2_text : Texture
#@export var p3_text : Texture
#@export var p4_text : Texture

@onready var player_1 = $Player1
@onready var player_2 = $Player2
@onready var player_3 = $Player3
@onready var player_4 = $Player4


@onready var p1 = $Player1/Frame1/P1
@onready var p2 = $Player2/Frame2/P2
@onready var p3 = $Player3/Frame3/P3
@onready var p4 = $Player4/Frame4/P4

@onready var bomb1 = $Player1/Bomb
@onready var bomb1_cooldown = $Player1/Bomb/BombCooldown
var bomb1_cooldown_percentage = 100
@onready var build1 = $Player1/Build
@onready var build1_cooldown = $Player1/Build/BuildCooldown
var build1_cooldown_percentage
@onready var run1 = $Player1/Run
@onready var run1_regen = $Player1/Run/RunRegen
var run1_gauge_percentage = 0

@onready var bomb2 = $Player2/Bomb
@onready var bomb2_cooldown = $Player2/Bomb/BombCooldown
var bomb2_cooldown_percentage = 100
@onready var build2 = $Player2/Build
@onready var build2_cooldown = $Player2/Build/BuildCooldown
var build2_cooldown_percentage
@onready var run2 = $Player2/Run
@onready var run2_regen = $Player2/Run/RunRegen
var run2_gauge_percentage = 0

@onready var bomb3 = $Player3/Bomb
@onready var bomb3_cooldown = $Player3/Bomb/BombCooldown
var bomb3_cooldown_percentage = 100
@onready var build3 = $Player3/Build
@onready var build3_cooldown = $Player3/Build/BuildCooldown
var build3_cooldown_percentage
@onready var run3 = $Player3/Run
@onready var run3_regen = $Player3/Run/RunRegen
var run3_gauge_percentage = 0

@onready var bomb4 = $Player4/Bomb
@onready var bomb4_cooldown = $Player4/Bomb/BombCooldown
var bomb4_cooldown_percentage = 100
@onready var build4 = $Player4/Build
@onready var build4_cooldown = $Player4/Build/BuildCooldown
var build4_cooldown_percentage
@onready var run4 = $Player4/Run
@onready var run4_regen = $Player4/Run/RunRegen
var run4_gauge_percentage = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	if CharacterSelectionManager.player1 != null:
		player_1.show()
		p1.texture = CharacterSelectionManager.player1_texture
	if CharacterSelectionManager.player2 != null:
		player_2.show()	
		p2.texture = CharacterSelectionManager.player2_texture
	if CharacterSelectionManager.player3 != null:
		player_3.show()	
		p3.texture = CharacterSelectionManager.player3_texture
	if CharacterSelectionManager.player4 != null:
		player_4.show()	
		p4.texture = CharacterSelectionManager.player4_texture
	
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	# PLAYER 1
	if bomb1_cooldown.time_left > 0:
		bomb1_cooldown_percentage = (
			(1 - bomb1_cooldown.time_left / bomb1_cooldown.wait_time) * 100
			)
	bomb1.value = bomb1_cooldown_percentage
	
	if build1_cooldown.time_left > 0:
		build1_cooldown_percentage = (
			(1 - build1_cooldown.time_left / build1_cooldown.wait_time) * 100
			)
	build1.value = build1_cooldown_percentage
		
	run1.value = run1_gauge_percentage
	
	###############################################################################
	
	# PLAYER 2
	if bomb2_cooldown.time_left > 0:
		bomb2_cooldown_percentage = (
			(1 - bomb2_cooldown.time_left / bomb2_cooldown.wait_time) * 100
			)
	bomb2.value = bomb2_cooldown_percentage
	
	if build2_cooldown.time_left > 0:
		build2_cooldown_percentage = (
			(1 - build2_cooldown.time_left / build2_cooldown.wait_time) * 100
			)
	build2.value = build2_cooldown_percentage
		
	run2.value = run2_gauge_percentage
	
	###############################################################################
	
	# PLAYER 3
	if bomb3_cooldown.time_left > 0:
		bomb3_cooldown_percentage = (
			(1 - bomb3_cooldown.time_left / bomb3_cooldown.wait_time) * 100
			)
	bomb3.value = bomb3_cooldown_percentage
	
	if build3_cooldown.time_left > 0:
		build3_cooldown_percentage = (
			(1 - build3_cooldown.time_left / build3_cooldown.wait_time) * 100
			)
	build3.value = build3_cooldown_percentage
		
	run3.value = run3_gauge_percentage
	
	###############################################################################
	
	# PLAYER 4
	if bomb4_cooldown.time_left > 0:
		bomb4_cooldown_percentage = (
			(1 - bomb4_cooldown.time_left / bomb4_cooldown.wait_time) * 100
			)
	bomb4.value = bomb4_cooldown_percentage
	
	if build4_cooldown.time_left > 0:
		build4_cooldown_percentage = (
			(1 - build4_cooldown.time_left / build4_cooldown.wait_time) * 100
			)
	build4.value = build4_cooldown_percentage
		
	run4.value = run4_gauge_percentage
	
func _on_run1_regen_timeout():
	if run1_gauge_percentage <= 100:
		run1_gauge_percentage += 5
	
func _on_run2_regen_timeout():
	if run2_gauge_percentage <= 100:
		run2_gauge_percentage += 5
#
func _on_run3_regen_timeout():
	if run3_gauge_percentage <= 100:
		run3_gauge_percentage += 5
#
func _on_run4_regen_timeout():
	if run4_gauge_percentage <= 100:
		run4_gauge_percentage += 5
