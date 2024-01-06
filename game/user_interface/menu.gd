extends Control
@onready var play_button = $MarginContainer/VBoxContainer/Button
@onready var settings_button = $MarginContainer/VBoxContainer/Button2
@onready var exit_button = $MarginContainer/VBoxContainer/Button3

@onready var settings = $settings

# Called when the node enters the scene tree for the first time.
func _ready():
	play_button.pressed.connect(func(): get_tree().change_scene_to_file("res://game/levels/test_scene.tscn"))
	settings_button.pressed.connect(func(): settings.visible = !settings.visible)
	exit_button.pressed.connect(get_tree().quit)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
