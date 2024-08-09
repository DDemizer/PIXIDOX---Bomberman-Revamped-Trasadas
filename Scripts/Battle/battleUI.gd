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
@onready var punch1 = $Player1/Punch
@onready var punch1_cooldown = $Player1/Punch/PunchCooldown
var punch1_cooldown_percentage
@onready var run1 = $Player1/Run
@onready var run1_regen = $Player1/Run/RunRegen
var run1_gauge_percentage = 0
@export var running1_active = false


@onready var bomb2 = $Player2/Bomb
@onready var bomb2_cooldown = $Player2/Bomb/BombCooldown
var bomb2_cooldown_percentage = 100
@onready var build2 = $Player2/Build
@onready var build2_cooldown = $Player2/Build/BuildCooldown
var build2_cooldown_percentage
@onready var punch2 = $Player2/Punch
@onready var punch2_cooldown = $Player2/Punch/PunchCooldown
var punch2_cooldown_percentage
@onready var run2 = $Player2/Run
@onready var run2_regen = $Player2/Run/RunRegen
var run2_gauge_percentage = 0
@export var running2_active = false

@onready var bomb3 = $Player3/Bomb
@onready var bomb3_cooldown = $Player3/Bomb/BombCooldown
var bomb3_cooldown_percentage = 100
@onready var build3 = $Player3/Build
@onready var build3_cooldown = $Player3/Build/BuildCooldown
var build3_cooldown_percentage
@onready var punch3 = $Player3/Punch
@onready var punch3_cooldown = $Player3/Punch/PunchCooldown
var punch3_cooldown_percentage
@onready var run3 = $Player3/Run
@onready var run3_regen = $Player3/Run/RunRegen
var run3_gauge_percentage = 0
@export var running3_active = false

@onready var bomb4 = $Player4/Bomb
@onready var bomb4_cooldown = $Player4/Bomb/BombCooldown
var bomb4_cooldown_percentage = 100
@onready var build4 = $Player4/Build
@onready var build4_cooldown = $Player4/Build/BuildCooldown
var build4_cooldown_percentage
@onready var punch4 = $Player4/Punch
@onready var punch4_cooldown = $Player4/Punch/PunchCooldown
var punch4_cooldown_percentage
@onready var run4 = $Player4/Run
@onready var run4_regen = $Player4/Run/RunRegen
var run4_gauge_percentage = 0
@export var running4_active = false

var character_build_deduction = 9
#var build_cooldowns = []
# Called when the node enters the scene tree for the first time.
func _ready():
	BattleManager.connect('build1_activated_to_BUI', build1_start_cooldown)
	BattleManager.connect('build2_activated_to_BUI', build2_start_cooldown)
	BattleManager.connect('build3_activated_to_BUI', build3_start_cooldown)
	BattleManager.connect('build4_activated_to_BUI', build4_start_cooldown)
	BattleManager.connect('punch1_activated_to_BUI', punch1_start_cooldown)
	BattleManager.connect('punch2_activated_to_BUI', punch2_start_cooldown)
	BattleManager.connect('punch3_activated_to_BUI', punch3_start_cooldown)
	BattleManager.connect('punch4_activated_to_BUI', punch4_start_cooldown)
	BattleManager.connect('bomb1_activated_to_BUI', bomb1_start_cooldown)
	BattleManager.connect('bomb2_activated_to_BUI', bomb2_start_cooldown)
	BattleManager.connect('bomb3_activated_to_BUI', bomb3_start_cooldown)
	BattleManager.connect('bomb4_activated_to_BUI', bomb4_start_cooldown)
#	BattleManager.connect('running', on_running)
	build1_cooldown.wait_time = CharacterSelectionManager.character1_build_cooldown
	build2_cooldown.wait_time = CharacterSelectionManager.character2_build_cooldown
	build3_cooldown.wait_time = CharacterSelectionManager.character3_build_cooldown
	build4_cooldown.wait_time = CharacterSelectionManager.character4_build_cooldown
	build1_cooldown.start()
	build2_cooldown.start()
	build3_cooldown.start()
	build4_cooldown.start()
	
	
	
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
	
	if punch1_cooldown.time_left > 0:
		punch1_cooldown_percentage = (
			(1 - punch1_cooldown.time_left / punch1_cooldown.wait_time) * 100
			)
	punch1.value = punch1_cooldown_percentage
		
	run1.value = run1_gauge_percentage
	if run1_gauge_percentage < 10:
		BattleManager.running1_avail = false
	
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
	
	if punch2_cooldown.time_left > 0:
		punch2_cooldown_percentage = (
			(1 - punch2_cooldown.time_left / punch2_cooldown.wait_time) * 100
			)
	punch2.value = punch2_cooldown_percentage
		
	run2.value = run2_gauge_percentage
	if run2_gauge_percentage < 10:
		BattleManager.running2_avail = false
	
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
		
	if punch3_cooldown.time_left > 0:
		punch3_cooldown_percentage = (
			(1 - punch3_cooldown.time_left / punch3_cooldown.wait_time) * 100
			)
	punch3.value = punch3_cooldown_percentage
	
	run3.value = run3_gauge_percentage
	if run3_gauge_percentage < 10:
		BattleManager.running3_avail = false
	
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
	
	if punch4_cooldown.time_left > 0:
		punch4_cooldown_percentage = (
			(1 - punch4_cooldown.time_left / punch4_cooldown.wait_time) * 100
			)
	punch4.value = punch4_cooldown_percentage
		
	run4.value = run4_gauge_percentage
	if run4_gauge_percentage < 10:
		BattleManager.running4_avail = false
		

# BOMB
func _on_bomb1_cooldown_timeout():
	BattleManager.bomb1_active = true

func bomb1_start_cooldown():
	bomb1_cooldown.start()
	bomb1_cooldown_percentage = 0

func _on_bomb2_cooldown_timeout():
	BattleManager.bomb2_active = true

func bomb2_start_cooldown():
	bomb2_cooldown.start()
	bomb2_cooldown_percentage = 0
	
func _on_bomb3_cooldown_timeout():
	BattleManager.bomb3_active = true

func bomb3_start_cooldown():
	bomb3_cooldown.start()
	bomb3_cooldown_percentage = 0
	
func _on_bomb4_cooldown_timeout():
	BattleManager.bomb4_active = true
	
func bomb4_start_cooldown():
	bomb4_cooldown.start()
	bomb4_cooldown_percentage = 0

# BUILD
func _on_build1_cooldown_timeout():
	BattleManager.build1_active = true
	
func build1_start_cooldown():
	build1_cooldown.start()
	build1_cooldown_percentage = 0

func _on_build2_cooldown_timeout():
	BattleManager.build2_active = true
	
func build2_start_cooldown():
	build2_cooldown.start()
	build2_cooldown_percentage = 0

func _on_build3_cooldown_timeout():
	BattleManager.build3_active = true
	
func build3_start_cooldown():
	build3_cooldown.start()
	build3_cooldown_percentage = 0
	
func _on_build4_cooldown_timeout():
	BattleManager.build4_active = true
	
func build4_start_cooldown():
	build4_cooldown.start()
	build4_cooldown_percentage = 0
	
func _on_punch1_cooldown_timeout():
	BattleManager.punch1_active = true
	
func punch1_start_cooldown():
	punch1_cooldown.start()
	punch1_cooldown_percentage = 0

func _on_punch2_cooldown_timeout():
	BattleManager.punch2_active = true
	
func punch2_start_cooldown():
	punch2_cooldown.start()
	punch2_cooldown_percentage = 0

func _on_punch3_cooldown_timeout():
	BattleManager.punch3_active = true
	
func punch3_start_cooldown():
	punch3_cooldown.start()
	punch3_cooldown_percentage = 0
	
func _on_punch4_cooldown_timeout():
	BattleManager.punch4_active = true
	
func punch4_start_cooldown():
	punch4_cooldown.start()
	punch4_cooldown_percentage = 0


# RUNNING
func _on_run1_regen_timeout():
	if run1_gauge_percentage <= 100 and running1_active == false:
		run1_gauge_percentage += 5
	if run1_gauge_percentage > 10:
		BattleManager.running1_avail = true
	if run1_gauge_percentage >= 10 and running1_active == true:
		run1_gauge_percentage -= 10
	
		
func _on_run2_regen_timeout():
	if run2_gauge_percentage <= 100 and running2_active == false:
		run2_gauge_percentage += 5
	if run2_gauge_percentage > 10:
		BattleManager.running2_avail = true
	if run2_gauge_percentage >= 10 and running2_active == true:
		run2_gauge_percentage -= 10
		
func _on_run3_regen_timeout():
	if run3_gauge_percentage <= 100 and running3_active == false:
		run3_gauge_percentage += 5
	if run3_gauge_percentage > 10:
		BattleManager.running3_avail = true
	if run3_gauge_percentage >= 10 and running3_active == true:
		run3_gauge_percentage -= 10
		
func _on_run4_regen_timeout():
	if run4_gauge_percentage <= 100 and running4_active == false:
		run4_gauge_percentage += 5
	if run4_gauge_percentage > 10:
		BattleManager.running4_avail = true
	if run4_gauge_percentage >= 10 and running4_active == true:
		run4_gauge_percentage -= 10




