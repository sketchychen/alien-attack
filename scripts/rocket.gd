extends Area2D

@export var speed = 300
@export var damage = 1

func _physics_process(delta):
	global_position.y += -speed * delta


func _on_visible_on_screen_enabler_2d_screen_exited():
	queue_free() # Replace with function body.


func _on_area_entered(area):
	area.take_damage(damage)
	# TODO: particle explosion on hit
	die()


func die():
	queue_free()
