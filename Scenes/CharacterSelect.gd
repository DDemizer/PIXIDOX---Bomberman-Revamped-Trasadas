extends Sprite2D

const SPEED = 2

@onready var cursor_1 = $"."
@onready var cursor_2 = $"../Cursor2"
@onready var cursor_3 = $"../Cursor3"
@onready var cursor_4 = $"../Cursor4"

var player

func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Buttons
	var up = 11
	var down = 12
	var left = 13
	var right = 14
	var start_button = 6
	var select_button = 4

	# Players for Cursor
	if self == cursor_1:
		player = 0
	if self == cursor_2:
		player = 1
	if self == cursor_3:
		player = 2
	if self == cursor_4:
		player = 3
		
	# Cursor Movement
	if self.process_mode == 0:
		if Input.is_joy_button_pressed(player, up):
			position.y += -SPEED
		if Input.is_joy_button_pressed(player, down):
			position.y += SPEED
		if Input.is_joy_button_pressed(player, left):
			position.x += -SPEED
		if Input.is_joy_button_pressed(player, right):
			position.x += SPEED
	
