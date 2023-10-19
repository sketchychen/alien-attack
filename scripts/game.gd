extends Node2D


func _on_player_died():
	pass # Replace with function body.


func _on_enemy_spawner_enemy_spawn(enemy_instance):
	enemy_instance.died.connect(_on_enemy_died)
	add_child(enemy_instance)

func _on_enemy_died():
	print("oh no")
