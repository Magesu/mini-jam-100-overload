extends Area2D




export var speed = 150
onready var player = get_tree().root.get_node("Main/Player")
onready var timer = $Timer

export var timer_delay = 1.5

var direction = Vector2.ZERO
var velocity = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	direction = Vector2(cos(get_rotation()), sin(get_rotation()))
	
	timer.wait_time = timer_delay
	timer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	velocity = direction * speed
	position += velocity * delta




func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func _on_Timer_timeout():
	speed = 500
	scale = scale/3
	var ang = position.angle_to_point(player.position) + PI
	direction = Vector2(cos(ang), sin(ang))
	timer.stop()
