extends ParallaxLayer


var mirroring = Vector2(0, 0)
var offset = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	set_mirroring(mirroring)


func _process(delta):
	offset += 1
	set_motion_offset(Vector2(0, offset))
	motion_mirroring = Vector2(0, 1280)


