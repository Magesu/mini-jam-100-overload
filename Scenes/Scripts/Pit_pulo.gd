extends KinematicBody2D


onready var game = get_tree().root.get_node("Game")
onready var player = game.get_node("Player")
onready var animator = $AnimatedSprite
onready var colisao = $CollisionShape2D
onready var pulo_timer = $Timer_Pulo
onready var animacao_timer = $Animacao_Timer
onready var player_position = player.position
onready var hitbox = get_node("Area2D/CollisionShape2D")


export var pulo_timer_wait_time = 3
export var jump_speed = 200

var estado = 0

var posicao_relativa = Vector2(0 ,0)
var vec_zero = Vector2(0, 0)
var direction = Vector2(0, 0)

# Called when the node enters the scene tree for the first time.
func _ready():
	animator.play("default")
	pulo_timer.wait_time = pulo_timer_wait_time
	pulo_timer.start()
	hitbox.disabled = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if estado == 1:
		if abs((direction + (position - player_position).normalized()).length()) > 1:
			animator.play("pouso")
			hitbox.disabled = false
			animacao_timer.start()
			estado = 2
		else:
			move_and_slide(direction * jump_speed)

func no_ar():
	estado = 1
	animator.play("shadow")
	colisao.disabled = true
	player_position = player.position
	posicao_relativa = player_position - position
	direction = posicao_relativa.normalized()

func no_chao():
	estado = 0
	animator.play("default")
	hitbox.disabled = true
	colisao.disabled = false
	pulo_timer.start()

func _on_Lifespan_timeout():
	die()

func _on_Timer_Pulo_timeout():
	animator.play("pulo")
	pulo_timer.stop()
	animacao_timer.start()

func _on_Animacao_Timer_timeout():
	if estado == 0:
		animacao_timer.stop()
		no_ar()
	else:
		animacao_timer.stop()
		no_chao()

func die():
	game.boss_death()
	queue_free()
