extends ParallaxBackground

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var SCROLL_SPEED = 50
	scroll_offset.y += delta * SCROLL_SPEED
