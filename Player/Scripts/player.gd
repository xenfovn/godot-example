class_name Player extends CharacterBody2D

# hướng ấn nút
var direction : Vector2 = Vector2.ZERO
# hướng quay nhân vật
var cardinal_direction : Vector2 = Vector2.DOWN
# tốc độ nhân vật
var speed_move : float = 100.0
# trạng thái nhân vật
var state : String = "idle"

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite: Sprite2D = $Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	direction.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	direction.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	
	velocity = direction * speed_move
	
	if SetDirection() == true || SetState() == true:
		UpdateAnimation()
	pass

func _physics_process(delta: float) -> void:
	move_and_slide()
	pass
	

func SetDirection() -> bool:
	var new_direction : Vector2 = cardinal_direction

	if direction == Vector2.ZERO:
		return false

	if direction.y == 0:
		new_direction = Vector2.LEFT if direction.x < 0 else Vector2.RIGHT
	elif direction.x == 0:
		new_direction = Vector2.UP if direction.y < 0 else Vector2.DOWN

	if new_direction == cardinal_direction:
		return false
	cardinal_direction = new_direction
	sprite.scale.x = -1 if direction.x < 0 else 1
	return true
	
func SetState() -> bool:
	var new_state = "idle" if direction == Vector2.ZERO else "walk"
	
	if new_state == state:
		return false
	state = new_state
	return true
	
func UpdateAnimation() -> void:
	animation_player.play(state + "_" + AnimDirection())
	pass

func AnimDirection() -> String:
	if cardinal_direction == Vector2.DOWN:
		return "down"
	elif cardinal_direction == Vector2.UP:
		return "up"
	else:
		return "side"
