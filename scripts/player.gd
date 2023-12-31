extends CharacterBody2D

@export var rocket_scene: PackedScene
@export var health = 3
@export var shield = 5

signal health_init(value)
signal shield_init(value)
signal health_updated(new_value)
signal shield_updated(new_value)
signal died

var speed = 500
var screen_size

@onready var rocket_container = get_node("RocketContainer")
# does the same thing as if it were in _ready()
@onready var asplode_sound = $AsplodeSound
@onready var rocket_sound = $RocketSound


func _ready():
	screen_size = get_viewport_rect().size
	emit_signal("health_init", health)
	emit_signal("shield_init", shield)


func _process(delta):
	if Input.is_action_just_pressed("shoot"):
		shoot()


func _physics_process(delta):
	var direction_x = 0
	var direction_y = 0
	
	if Input.is_action_pressed("move_right"):
		direction_x += 1
	if Input.is_action_pressed("move_left"):
		direction_x += -1
	if Input.is_action_pressed("move_down"):
		direction_y += 1
	if Input.is_action_pressed("move_up"):
		direction_y += -1
	
	velocity = Vector2(direction_x, direction_y).normalized() * speed
	
	move_and_slide()
	
	global_position = global_position.clamp(Vector2(0, 0), screen_size)


func shoot():
	var rocket_instance = rocket_scene.instantiate()
	rocket_container.add_child(rocket_instance)
	rocket_instance.global_position = global_position
	rocket_instance.global_position.y += -80
	rocket_sound.play()


func take_damage(value):
	asplode_sound.play()
	health -= value
	emit_signal("health_updated", health)
	if health <= 0:
		die()


func die():
	emit_signal("died")
	SignalBus.game_over.emit()
	queue_free()
