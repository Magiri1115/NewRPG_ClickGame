# scripts/tako.gd
extends Area2D
signal game_over


var velocity: Vector2 = Vector2.ZERO
#落下速度
var gravity_force: float = 5.0
#跳ね返り係数
var bounce_strength: float = -900.0

var screen_width: float

#初期関数
func _ready():
	screen_width = get_viewport_rect().size.x # 画面幅を取得
	position = Vector2(320, 50) # 初期位置（画面上部）

#オブジェクトの運動関数
func _process(delta):
	velocity.y += gravity * delta
	position += velocity * delta
	# 左右の壁で跳ね返る処理
	if position.x < 0 or position.x > screen_width:
		# x方向の速度を反転させて跳ね返る
		velocity.x *= -1 
	# 画面下端に到達した場合
	if position.y > 600: 
		emit_signal("game_over")

#クリックで跳ね返す関数
func _on_Area2D_input_event(viewport, event, shape_idx):
	if event is InputEventScreenTouch or event is InputEventMouseButton:
		if event.is_pressed():
			# クリック時の跳ね返りの角度をランダムに変化させる
			var angle_variation = deg_to_rad(randf_range(-30, 30))
			var bounce_vector = Vector2(0, bounce_strength).rotated(angle_variation)
			velocity = bounce_vector
