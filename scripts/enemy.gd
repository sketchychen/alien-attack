extends Area2D


@export var speed = 300
@export var health = 1
@export var damage = 1
@export var points = 1

@onready var hit_sound = $HitSound
@onready var hitbox = $Hitbox

signal died

var waypoints
var next_waypoint = 1



func fly_straight(delta):
	global_position.y += delta * speed


func take_damage(value = 1):
	hit_sound.play()
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
	fly_straight(delta)


func _on_area_entered(area):
	take_damage(area.damage)


func _on_body_entered(body):
	take_damage()
	body.take_damage(damage)
