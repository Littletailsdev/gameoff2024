extends CharacterBody2D


const SPEED = 150.0
const JUMP_VELOCITY = -400.0
enum States{IDLE, WALKING}
var state: States = States.IDLE: set = set_state
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		state = States.WALKING
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		state = States.IDLE

	move_and_slide()
	
	
func set_state(new_state):
	state = new_state
	# You can check both the previous and the new state to determine what to do when the state changes. This checks the previous state.
	if state == States.IDLE:
		animated_sprite.play("Idle")
	if state == States.WALKING:
		animated_sprite.play("Walking")
