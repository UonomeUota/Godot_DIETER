extends Node2D

@export var enemy_scene: PackedScene  # エディタでEnemy1シーンを設定するための変数
@export var spawn_interval: float = 3.0  # スポーン間隔（秒）
var timer: Timer

func _ready():
	timer = Timer.new()
	add_child(timer)
	timer.wait_time = spawn_interval
	timer.connect("timeout", _on_timer_timeout)
	timer.start()

func _on_timer_timeout():
	var enemy = enemy_scene.instantiate()
	# ランダムな位置にスポーン（画面外から）
	var viewport_size = get_viewport_rect().size
	var spawn_position = Vector2.ZERO
	
	# ランダムに画面外の位置を決定
	match randi() % 4:
		0:  # 上
			spawn_position.x = randf_range(0, viewport_size.x)
			spawn_position.y = -50
		1:  # 右
			spawn_position.x = viewport_size.x + 50
			spawn_position.y = randf_range(0, viewport_size.y)
		2:  # 下
			spawn_position.x = randf_range(0, viewport_size.x)
			spawn_position.y = viewport_size.y + 50
		3:  # 左
			spawn_position.x = -50
			spawn_position.y = randf_range(0, viewport_size.y)
	
	enemy.global_position = spawn_position
	add_child(enemy) 
