extends CharacterBody2D
#sprites:
@onready var dog_sprite: AnimatedSprite2D = $DogSprite
@onready var cat_sprite: AnimatedSprite2D = $CatSprite

#collisionshapes
@onready var dog_collision: CollisionShape2D = $DogCollision
@onready var cat_collision: CollisionShape2D = $CatCollision

#lights
@onready var dog_light: PointLight2D = $DogLight
@onready var cat_light: PointLight2D = $CatLight

const SPEED = 150.0
const JUMP_VELOCITY = -400.0

enum States{IDLE, WALKING}
var state: States = States.IDLE: set = set_state

var current_sprite
var current_collision
var current_light

enum AnimalStates{DOG, CAT, RAT, BIRD}
var animal_state: AnimalStates = AnimalStates.DOG: set = set_animal_state
var current_animal: AnimalStates

func _ready() -> void:
	current_animal = AnimalStates.DOG
	current_sprite = dog_sprite
	current_collision = dog_collision
	current_light = dog_light
	
func set_animal_state(new_state):
	animal_state = new_state
	turnOfCurrent()
	if animal_state == AnimalStates.DOG:
		dog_sprite.visible = true
		dog_collision.disabled = false
		dog_light.visible = true
		current_sprite = dog_sprite
		current_collision = dog_collision
		current_light = dog_light
	if animal_state == AnimalStates.CAT:
		cat_sprite.visible = true
		cat_collision.disabled = false
		cat_light.visible = true
		current_sprite = cat_sprite
		current_collision = cat_collision
		current_light = cat_light

	#if animal_state == AnimalStates.RAT:
		#current_animal.visible = false
		#rat.visible = true
	#if animal_state == AnimalStates.BIRD:
		#current_animal.visible = false
		#bird.visible = true
		
func turnOfCurrent():
	current_sprite.visible = false
	current_collision.disabled = true
	current_light.visible = false
		
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ChangeType"):
		animal_state = AnimalStates.CAT
		
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
		current_sprite.play("Idle")
	if state == States.WALKING:
		current_sprite.play("Walking")

		
		


		
