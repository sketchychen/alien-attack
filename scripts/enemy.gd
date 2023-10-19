extends Area2D


@export var speed = 300
@export var health = 1
@export var damage = 1
@export var points = 1

@onready var hitbox = $Hitbox

signal died

var waypoints
var next_waypoint = 1

func set_waypoints(waypoints_instance):
	waypoints = waypoints_instance

func follow_waypoints(delta):
	if next_waypoint < waypoints.get_child_count():
		var destination = waypoints.get_child(next_waypoint).global_position
		global_position = global_position.move_toward(destination, delta * speed)
		if global_position == destination:
			next_waypoint += 1
	else:
		queue_free()


func fly_straight(delta):
	global_position.y += delta * speed


func take_damage(value):
	health -= value
	if health <= 0:
		SignalBus.enemy_died.emit(points)
		die()

func die():
	died.emit()
	queue_free()


func _ready():
	if waypoints:
		global_position = waypoints.get_child(0).global_position


func _physics_process(delta):
	if waypoints:
		follow_waypoints(delta)
	else:
		fly_straight(delta)


func _on_area_entered(area):
	take_damage(area.damage)


func _on_body_entered(body):
	body.take_damage(damage)
