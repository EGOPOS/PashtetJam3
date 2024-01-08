extends Control

@onready var master_slider = $"TabContainer/Аудио/MarginContainer/VBoxContainer/HBoxContainer/HSlider"
@onready var sfx_slider = $"TabContainer/Аудио/MarginContainer/VBoxContainer/HBoxContainer2/HSlider"
@onready var music_slider = $"TabContainer/Аудио/MarginContainer/VBoxContainer/HBoxContainer3/HSlider"

@onready var vsync_box = $"TabContainer/Видео/MarginContainer/VBoxContainer/HBoxContainer/CheckBox"
@onready var fullscreen_box = $"TabContainer/Видео/MarginContainer/VBoxContainer/HBoxContainer2/CheckBox"

func _ready():
	master_slider.value = AudioServer.get_bus_volume_db(0)
	sfx_slider.value = AudioServer.get_bus_volume_db(1)
	music_slider.value = AudioServer.get_bus_volume_db(2)

	var change_volume = func(value, bus):
		AudioServer.set_bus_volume_db(bus, value)

	master_slider.value_changed.connect(Callable(change_volume).bind(0))
	sfx_slider.value_changed.connect(Callable(change_volume).bind(1))
	music_slider.value_changed.connect(Callable(change_volume).bind(2))
	
	vsync_box.button_pressed = DisplayServer.window_get_vsync_mode() == DisplayServer.VSYNC_ENABLED
	vsync_box.toggled.connect( func(value):
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED if not value else DisplayServer.VSYNC_ENABLED)
	)
	
	fullscreen_box.button_pressed = DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN
	fullscreen_box.toggled.connect( func(value):
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED if not value else DisplayServer.WINDOW_MODE_FULLSCREEN)
	)
