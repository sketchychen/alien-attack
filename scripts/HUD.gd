extends Panel


@export var health_bar: ProgressBar
@export var shield_bar: ProgressBar
@export var score_label: Label

var score = 0

func _ready():
	SignalBus.enemy_died.connect(_on_enemy_died)
	pass

func _on_enemy_died(points):
	score += points
	score_label.text = format_score(score)


func _on_player_health_updated(new_value):
	health_bar.value = new_value


func _on_player_shield_updated(new_value):
	shield_bar.value = new_value


func _on_player_health_init(value):
	health_bar.max_value = value
	health_bar.value = value


func _on_player_shield_init(value):
	shield_bar.max_value = value
	shield_bar.value = value


func format_score(value):
	return "%06d" % value
