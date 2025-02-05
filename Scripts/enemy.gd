#enemy_1.gd
extends CharacterBody2D

@onready var player = get_tree().get_first_node_in_group("player")  # プレイヤーを取得
@onready var animated_sprite = $AnimatedSprite2D  # アニメーション用
@onready var collision_shape = $CollisionShape2D  # 衝突判定用

var speed = 30  # 敵の移動速度
var damage = 5  # プレイヤーに与えるダメージ
var score = 0  # スコアを管理する変数

func _ready():
	input_pickable = true  # クリック判定を有効化
	connect("input_event", _on_input_event)  # 入力イベントを接続

func _on_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			player.score += 1 
			player.update_score_display()
			queue_free()  # 敵を消滅させる

func _physics_process(_delta):
	if player:
		var direction = (player.global_position - global_position).normalized()  # プレイヤーへの方向を求める
		velocity = direction * speed  # 速度を設定
		move_and_slide()  # 物理演算を適用して移動

		# プレイヤーの方向に合わせて向きを変える
		if direction.x > 0:
			animated_sprite.flip_h = false  # 右向き
		elif direction.x < 0:
			animated_sprite.flip_h = true  # 左向き

func _on_hit_box_area_entered(area: Area2D) -> void:
	print("enemy!")
	print(player.health)
	if area.get_parent().is_in_group("player"):
		var target_player = area.get_parent()  # プレイヤーのメインノードを取得
		target_player.health -= damage  # プレイヤーの体力からダメージを奪う
		target_player.update_health_display()  # HP表示を更新
		queue_free()  # 敵を消滅させる
