extends CanvasLayer

class_name Dialogue

@onready var label: RichTextLabel = get_node("Control/label")
@onready var animation_player: AnimationPlayer = get_node("AnimationPlayer")
@onready var audio_stream_player = $AudioStreamPlayer

@export var text_speed: float = 0.02

@export_multiline
var dialogue_pages: Array[String]
var current_page = 0


signal dialogue_ended
signal page_changed

func _ready():
	noise.seed = randi()
	
	animation_player.play("show")
	await animation_player.animation_finished
	
	update_text()
	text_animation()
	page_changed.connect(text_animation)
	
	get_tree().paused = true

func next_page():
	if label.visible_characters != label.text.length():
		label.visible_characters = label.text.length()
		return
	set_current_page((current_page+1) % dialogue_pages.size())
	page_changed.emit()

func text_animation():
	for c in range(label.text.length()+1):
		await get_tree().create_timer(text_speed).timeout
		if label.visible_characters == label.text.length():
			break
		label.visible_characters = c
		play_char_audio(c)

func set_current_page(value):
	current_page = value
	if !current_page:
		animation_player.play("hide")
		await animation_player.animation_finished
		dialogue_ended.emit()
		get_tree().paused = false
		queue_free()
		return
	update_text()

func update_text():
	label.text = dialogue_pages[current_page]
	label.visible_characters = 0

func _on_texture_button_pressed():
	next_page()

func _input(event):
	if Input.is_action_just_pressed("ui_accept"):
		next_page()

var noise = FastNoiseLite.new()

func play_char_audio(characters: int):
	var new_pitch: float = abs(noise.get_noise_1d(characters)) * 2
	new_pitch = clamp(new_pitch, 0.9, 1.2)
	audio_stream_player.set_pitch_scale(new_pitch)
	audio_stream_player.play()
