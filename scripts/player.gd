extends Node2D

@onready var dog: CharacterBody2D = $Dog
@onready var cat: CharacterBody2D = $Cat
@onready var rat: CharacterBody2D = $Rat
@onready var bird: CharacterBody2D = $Bird

var current_animal: CharacterBody2D
enum AnimalStates{DOG, CAT, RAT, BIRD}
var animal_state: AnimalStates = AnimalStates.DOG: set = set_animal_state

func _ready() -> void:
	current_animal = dog
	
func set_animal_state(new_state):
	animal_state = new_state
	if animal_state == AnimalStates.DOG:
		dog.visible = true
		current_animal = dog
	if animal_state == AnimalStates.CAT:
		current_animal.visible = false
		cat.visible = true
		current_animal = cat
		print(current_animal)
	if animal_state == AnimalStates.RAT:
		current_animal.visible = false
		rat.visible = true
	if animal_state == AnimalStates.BIRD:
		current_animal.visible = false
		bird.visible = true
		
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ChangeType"):
		animal_state = AnimalStates.CAT
		
		


		
