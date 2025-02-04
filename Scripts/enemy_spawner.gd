extends Node2D

@export var enemy_scenes: Array[PackedScene]  # スポーンする敵の種類
@export var spawn_margin: int = 50  # 画面外から敵をスポーンさせる範囲

@onready var timer = $Timer  # Timer ノード

func _ready():
	randomize()  # ランダムシードを初期化（これを呼ぶことでrandf_rangeなどがランダムになる）
	timer.start()  # タイマーをスタート
	add_to_group("enemy")  # 敵を "enemy" グループに追加

	timer.timeout.connect(_on_timer_timeout)

func _on_timer_timeout():
	if enemy_scenes.is_empty():
		return

	# 画面の四辺（上・下・左・右）のどこからスポーンするかを決める
	var viewport_rect = get_viewport_rect()
	var side = randi() % 4  # 0: 上, 1: 下, 2: 左, 3: 右
	var spawn_position = Vector2.ZERO

	match side:
		0: spawn_position = Vector2(randf_range(0, viewport_rect.size.x), -spawn_margin)  # 上
		1: spawn_position = Vector2(randf_range(0, viewport_rect.size.x), viewport_rect.size.y + spawn_margin)  # 下
		2: spawn_position = Vector2(-spawn_margin, randf_range(0, viewport_rect.size.y))  # 左
		3: spawn_position = Vector2(viewport_rect.size.x + spawn_margin, randf_range(0, viewport_rect.size.y))  # 右

	# ランダムな敵を選んでインスタンス化
	var enemy_scene = enemy_scenes[randi() % enemy_scenes.size()]  # ランダムに選択
	var enemy_instance = enemy_scene.instantiate()

	# 位置をセットしてシーンに追加
	enemy_instance.global_position = spawn_position
	get_parent().add_child(enemy_instance)  # 親（ゲームシーン）に追加
