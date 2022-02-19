extends Area2D




export var speed = 250


var direction = Vector2.ZERO
var velocity = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	direction = Vector2(cos(get_rotation()), sin(get_rotation()))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	velocity = direction * speed
	position += velocity * delta




func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

