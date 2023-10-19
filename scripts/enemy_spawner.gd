extends Node

@export var enemy_scene: PackedScene
@export var waypoints_scene: PackedScene

@onready var spawn_timer = $SpawnTimer
@onready var spawn_line = $SpawnLine

signal enemy_spawn(enemy_instance)


func spawn_enemy_with_waypoints(enemy, waypoints):
	var enemy_instance = enemy.instantiate()
	var waypoints_instance = waypoints.instantiate()
	enemy_instance.set_waypoints(waypoints_instance)
	add_child(enemy_instance)
	

func spawn_enemy(enemy):
	var random_spawn_position = spawn_line.get_children().pick_random().global_position
	var enemy_instance = enemy.instantiate()
	enemy_instance.global_position = random_spawn_position
	enemy_spawn.emit(enemy_instance)
	


func _on_spawn_timer_timeout():
	spawn_enemy(enemy_scene)
