extends Control

@onready var player_lives_label = $MarginContainer/HFlowContainer/HBoxContainer/Label
@onready var famine_bar = $MarginContainer/HFlowContainer/HBoxContainer2/ProgressBar

func set_player_lives(value: int):
	player_lives_label.text = ("0" if value < 10 else "") + str(value) + "/20"

func set_monster_famine(value: int):
	famine_bar.value = value

func _ready():
	set_player_lives(5)
