extends Area2D


# Export variables
export var lifespan_wait_time = 5

# Nodes
onready var lifespan = get_node("Lifespan")

# Called when the node enters the scene tree for the first time.
func _ready():
	lifespan.wait_time = lifespan_wait_time
	lifespan.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_VisibilityNotifier2D_screen_exited():
	# Kills the bullet when it goes offscreen
	queue_free()

func _on_Lifespan_timeout():
	queue_free()

func _on_StaticBullet_area_entered(area):
	if area.is_in_group("player"):
		queue_free()
