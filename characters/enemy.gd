extends RigidBody2D


var Explosion = preload("res://characters/explosion.tscn")
var explosions = []
var loc
var sz


func _provide_jitter():
	var random = RandomNumberGenerator.new()
	random.randomize()
	var jitter_x = random.randfn(loc.x, int(sz / 5.0))
	var jitter_y = random.randfn(loc.y, int(sz / 5.0))
	return Vector2(jitter_x, jitter_y)
	
func explode():
	loc = _provide_jitter()
	var explosion: AnimatedSprite2D = Explosion.instantiate()
	get_parent().add_child(explosion)
	explosions.append(explosion)
	explosion.position = loc
	explosion.visible = true
	explosion.connect("animation_finished", animation_finished)
	explosion.play("default")
	
func animation_finished():
	var exploded = []
	for item in explosions:
		if not item.is_playing():
			exploded.append(item)
	
	for exp in exploded:
		delete_explosion(exp)


func delete_explosion(exp):
	var index = explosions.find(exp)
	if index > -1:
		exp.hide()
		exp.queue_free()
		explosions.remove_at(index)
		
func die():
	hide()
	#queue_free()
	
func start_explosions(src_center: Vector2, src_size: int):
	sz = src_size
	loc = src_center
	var random = RandomNumberGenerator.new()
	random.randomize()
	for _i in range(random.randi_range(2, 4)):
		var wait_time = random.randf_range(0.1, 0.4)
		var timer: SceneTreeTimer = get_tree().create_timer(wait_time)
		timer.connect("timeout", explode)
	var timer: SceneTreeTimer = get_tree().create_timer(0.01)
	timer.connect("timeout", die)
	
