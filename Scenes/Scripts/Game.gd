extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var charge_speed = 50
var charge_percentage = 0
var alive_bosses = 0

# Nodes
#onready var enemy = get_node("Enemy/EnemyController")
#onready var debug_menu = get_node("CanvasLayer/Debug Menu")
onready var charge_line = get_node("Charge")
onready var overload_line = get_node("Overload")
onready var score = get_node("Score")
onready var boss_spawn = get_node("BossSpawn")

# Scenes
var bosses = [preload("res://Scenes/AngyChihuahua.tscn"), preload("res://Scenes/Dalmatian1.tscn"), preload("res://Scenes/Fluffy.tscn"), preload("res://Scenes/LowCorgi.tscn"), preload("res://Scenes/Pit_pulo.tscn")]
onready var player = get_node("Player")

# Signal
signal overload

# Called when the node enters the scene tree for the first time.
func _ready():
	$ColorRect/AnimationPlayer.play("rainbow_grad")
	$Charge/AnimationPlayer.play("inverted_rainbow")
	
	var boss = bosses[2].instance()
	boss.global_position = boss_spawn.global_position
	add_child(boss)
	alive_bosses += 1


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Changes the second point of Charge until it meets the second point of Overload
	if charge_line.points[1].x < overload_line.points[1].x:
		charge_line.points[1] = (charge_line.points[1]+Vector2(delta*charge_speed,0))
	
	# Calculates the charge % based on the lenght of each line
	var overload_limit = overload_line.points[1].x - overload_line.points[0].x
	var current_charge = charge_line.points[1].x - charge_line.points[0].x
	charge_percentage = current_charge/overload_limit
	
	if charge_percentage >= 1 and charge_percentage <= 2:
		emit_signal("overload")
	
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

func reset_charge():
	charge_line.points[1].x = overload_line.points[0].x

func _on_AnimationPlayer_animation_finished(_anim_name):
	$ColorRect/AnimationPlayer.play("rainbow_grad")
	$Charge/AnimationPlayer.play("inverted_rainbow")

func spawn_new_boss():
	if alive_bosses == 0:
		yield(get_tree().create_timer(3),"timeout")
		
		if score.score > 100:
			var rand_num = randi() % 2
			if rand_num == 1:
				for i in 2:
					var boss = bosses[randi() % bosses.size()].instance()
					boss.global_position = boss_spawn.global_position + Vector2(400 * i, 0) + Vector2(-200, 0)
					if boss.is_in_group("dalmatian"):
						alive_bosses += 4
					else:
						alive_bosses += 1
					add_child(boss)
			else:
				var boss = bosses[randi() % bosses.size()].instance()
				boss.global_position = boss_spawn.global_position
				add_child(boss)
				if boss.is_in_group("dalmatian"):
					alive_bosses += 4
				else:
					alive_bosses += 1
		elif score.score > 200:
			var rand_num = randi() % 3
			if rand_num == 1:
				for i in 3:
					var boss = bosses[randi() % bosses.size()].instance()
					boss.global_position = boss_spawn.global_position + Vector2(200 * i, 0) + Vector2(-200, 0)
					if boss.is_in_group("dalmatian"):
						alive_bosses += 4
					else:
						alive_bosses += 1
					add_child(boss)
			elif rand_num == 2:
				for i in 2:
					var boss = bosses[randi() % bosses.size()].instance()
					boss.global_position = boss_spawn.global_position + Vector2(400 * i, 0) + Vector2(-200, 0)
					if boss.is_in_group("dalmatian"):
						alive_bosses += 4
					else:
						alive_bosses += 1
					add_child(boss)
			else:
				var boss = bosses[randi() % bosses.size()].instance()
				boss.global_position = boss_spawn.global_position
				add_child(boss)
				if boss.is_in_group("dalmatian"):
					alive_bosses += 4
				else:
					alive_bosses += 1
		else:
			var boss = bosses[randi() % bosses.size()].instance()
			boss.global_position = boss_spawn.global_position
			if boss.is_in_group("dalmatian"):
				alive_bosses += 4
			else:
				alive_bosses += 1
			add_child(boss)

func boss_death():
	alive_bosses -= 1
	
	if alive_bosses == 0:
		spawn_new_boss()

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

func _on_Game_overload():
	for child in get_children():
		if not child.is_in_group("must_survive"):
			child.visible = false
	get_tree().paused = true
	reset_charge()
	$AnimatedSprite.play("default")
	$AnimatedSprite.visible = true
	$Label.visible = true
	$Timer.start(2)
