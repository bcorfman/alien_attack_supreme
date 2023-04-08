extends RigidBody2D

signal explosions_finished
var explosions = []
var explosion_sounds = []
@onready var random = RandomNumberGenerator.new()


func _get_explosion(idx: int) -> AnimatedSprite2D:
	return $Ship.get_node("Explosion" + str(idx))

func _get_explosion_sound(idx: int) -> AudioStreamPlayer2D:
	return get_node("ExplosionSound" + str(idx))

	
func _provide_jitter(extent: float):
	var rng = extent / 3.0
	var jitter_x = random.randf_range(-rng, rng)
	var jitter_y = random.randf_range(-rng, rng)
	return Vector2(jitter_x, jitter_y)
	
func animation_finished():
	var unfinished_explosions = false
	for i in [1, 5]:
		var explosion = _get_explosion(i)
		if not explosion.is_playing():
			explosion.visible = false
			explosion.hide()
			var sound: AudioStreamPlayer2D = _get_explosion_sound(i)
			sound.play()
		if explosion.visible:
			unfinished_explosions = true
			
	if not unfinished_explosions:		
		explosions_finished.emit()

func explode():
	var extent = $Ship.get_rect().size.x
	var loc = _provide_jitter(extent)
	var explosion = explosions.pop_back()
	explosion.offset = loc
	explosion.show()
	explosion.connect("animation_finished", animation_finished)
	explosion.play("default")
	
func start_explosions():
	random.randomize()
	for i in range(1, 5): 
		var	explosion: AnimatedSprite2D = _get_explosion(i)
		explosions.append(explosion)
		var wait_time = random.randf_range(0.1, 0.4)
		var timer: SceneTreeTimer = get_tree().create_timer(wait_time)
		timer.connect("timeout", explode)
	
