extends Control



@export var label: Label
@export var label2: Label


func _ready():
	SignalBus.game_start.connect(_on_game_start)
	SignalBus.game_over.connect(_on_game_over)


func _on_game_start():
	visible = false


func _on_game_over():
	label.text = "Game Over"
	label2.text = "Press Enter\nto Retry"
	visible = true
