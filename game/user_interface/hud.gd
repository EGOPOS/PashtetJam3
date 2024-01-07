extends Control

@onready var player_lives_label = $MarginContainer/HFlowContainer/HBoxContainer/Label
@onready var hungry_bar = $MarginContainer/HFlowContainer/HBoxContainer2/ProgressBar

var max_player_lives: int = 20

func set_player_lives(value: int):
	player_lives_label.text = ("0" if value < 10 else "") + str(value) + "/" + str(max_player_lives)

func set_monster_hungry(value: int):
	hungry_bar.value = value

func _ready():
	set_player_lives(5)
