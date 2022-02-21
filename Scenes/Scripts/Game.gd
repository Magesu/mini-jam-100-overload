extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var charge_speed = 1

# Nodes
#onready var enemy = get_node("Enemy/EnemyController")
#onready var debug_menu = get_node("CanvasLayer/Debug Menu")
onready var charge_line = get_node("Charge")
onready var overload_line = get_node("Overload")
onready var score = get_node("Score")
onready var boss_spawn = get_node("BossSpawn")

# Scenes
var bosses = [preload("res://Scenes/AngyChihuahua.tscn"), preload("res://Scenes/Dalmatian1.tscn"), preload("res://Scenes/Fluffy.tscn"), preload("res://Scenes/LowCorgi.tscn")]


# Called when the node enters the scene tree for the first time.
func _ready():
	$ColorRect/AnimationPlayer.play("rainbow_grad")
	$Charge/AnimationPlayer.play("inverted_rainbow")
	
	var boss = bosses[0].instance()
	boss.global_position = boss_spawn.global_position
	add_child(boss)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	# Changes the second point of Charge until it meets the second point of Overload
	if charge_line.points[1].x < overload_line.points[1].x:
		charge_line.points[1] = (charge_line.points[1]+Vector2(delta*charge_speed,0))
	
	# If Esc is pressed, returns to the main menu
	if Input.is_action_just_pressed("ui_cancel"):
		Global.new_score("Your awesome name", $Score.score)
		get_tree().change_scene("res://Main.tscn")

# Debug box updating the game when values are changed
#func _on_RotateSpeedSpinBox_value_changed(value):
#	enemy.rotate_speed = value
#	enemy.update()
#
#func _on_TimerWaitTimeSpinBox_value_changed(value):
#	enemy.shoot_timer_wait_time = value
#	enemy.update()
#
#func _on_SpawnpointNumberSpinBox_value_changed(value):
#	enemy.spawnpoint_count = value
#	enemy.update()
#
#func _on_RadiusSpinBox_value_changed(value):
#	enemy.radius = value
#	enemy.update()
#
#func _on_BulletSpeedSpinBox_value_changed(value):
#	enemy.bullet_speed = value
#	enemy.update()
#
#func _on_TurnsCheckButton_toggled(button_pressed):
#	enemy.turns = button_pressed
#	enemy.update()
#
#func _on_TurnTimerWaitTime_value_changed(value):
#	enemy.turn_timer_wait_time = value
#	enemy.update()


func _on_AnimationPlayer_animation_finished(anim_name):
	$ColorRect/AnimationPlayer.play("rainbow_grad")
	$Charge/AnimationPlayer.play("inverted_rainbow")

# When receives the custom signal player_hit, pauses the game and starts a timer
func _on_Player_player_hit():
	var timer = $Timer
	get_tree().paused = true
	timer.start(2)

# When the pause timer runs out, checks the current score and returns to the menu
func _on_Timer_timeout():
	get_tree().paused = false
	Global.new_score("Your awesome name", $Score.score)
	get_tree().change_scene("res://Main.tscn")
