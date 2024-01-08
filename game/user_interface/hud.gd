extends Control

@onready var player_lives_label = $MarginContainer/HFlowContainer/HBoxContainer/Label
@onready var hungry_bar = $MarginContainer/HFlowContainer/HBoxContainer2/ProgressBar
@onready var pause_menu = $Control
@onready var settings = $Control/settings
@onready var vignette: TextureRect = $Vignette

var max_player_lives: int = 20

func set_player_lives(value: int):
	player_lives_label.text = ("0" if value < 10 else "") + str(value) + "/" + str(max_player_lives)

func set_monster_hungry(value: int):
	hungry_bar.value = value

func change_vignette_visibility(new_level: float):
	#var tween: Tween = get_tree().create_tween()
	var new_color: Color = vignette.modulate
	
	new_color.a = new_level
	vignette.modulate = new_color
	#tween.tween_property(vignette, "modulate", new_color, 0.1)

func _ready():
	$Control/VBoxContainer/Button.pressed.connect(switch_pause)
	$Control/VBoxContainer/Button2.pressed.connect(func(): settings.visible = !settings.visible)
	$Control/VBoxContainer/Button3.pressed.connect(get_tree().quit)

func switch_pause():
	pause_menu.visible = !pause_menu.visible
	get_tree().paused = !get_tree().paused

func _input(event):
	if Input.is_action_just_pressed("ui_cancel"):
		switch_pause()
