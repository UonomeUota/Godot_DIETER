extends CharacterBody2D

@onready var anim_sprite = $AnimatedSprite2D  # AnimatedSprite2D ノードを取得

const SPEED = 50.0  # 移動速度
var health = 100  # プレイヤーの体力


func _ready():
	anim_sprite.play("idle")  # ゲーム開始時は idle アニメーションを再生


func _physics_process(delta):
	var direction = Vector2.ZERO  # 移動方向を初期化

	# WASD での移動入力
	if Input.is_action_pressed("walk_right"):
		direction.x += 1
	if Input.is_action_pressed("walk_left"):
		direction.x -= 1
	if Input.is_action_pressed("walk_backward"):
		direction.y += 1
	if Input.is_action_pressed("walk_forward"):
		direction.y -= 1

	# 移動方向に基づいてアニメーションを再生
	if direction.length() > 0:
		velocity = direction.normalized() * SPEED  # 移動方向と速度を設定

		# 移動方向に合わせてアニメーションを変更
		if direction.y < 0:
			anim_sprite.play("walk_forward")  # W キー（上向き）
		elif direction.y > 0:
			anim_sprite.play("walk_backward")  # S キー（下向き）
		elif direction.x < 0:
			anim_sprite.play("walk_left")  # A キー（左向き）
		elif direction.x > 0:
			anim_sprite.play("walk_right")  # D キー（右向き）

	else:
		velocity = Vector2.ZERO  # 止まっている時は速度をゼロに
		anim_sprite.play("idle")  # 静止アニメーションを再生

	move_and_slide()  # velocity プロパティを使用して移動


# 衝突時にダメージを与える
func _on_Player_body_entered(body):
	if body.is_in_group("enemy"):  # 敵キャラクターにぶつかった場合
		health -= 10  # ダメージを受ける
		print("Health: ", health)
