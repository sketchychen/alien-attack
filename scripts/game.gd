extends Node2D


var is_paused = true
var is_ongoing = false
var is_retry_ready = false


func _ready():
	SignalBus.game_over.connect(_on_game_over)
	update_pause_state(true)


func _on_game_over():
	is_ongoing = false
	is_retry_ready = true
	update_pause_state(true)


func _on_enemy_spawner_enemy_spawn(enemy_instance):
	enemy_instance.died.connect(_on_enemy_died)
	add_child(enemy_instance)


func _on_enemy_spawner_path_spawn(path_instance):
	add_child(path_instance)
	path_instance.enemy.died.connect(_on_enemy_died)


func _on_enemy_died():
	pass


func _input(event):
	if event.is_action_pressed("start") and not is_ongoing and not is_retry_ready:
		SignalBus.game_start.emit()
		is_ongoing = true
		update_pause_state(false)
	if event.is_action_pressed("start") and not is_ongoing and is_retry_ready:
		get_tree().reload_current_scene()
	if event.is_action_pressed("pause") and is_ongoing:
		update_pause_state(not is_paused)


func update_pause_state(pause):
	is_paused = pause
	get_tree().paused = is_paused
	

