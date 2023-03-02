class_name Player extends CharacterBody3D

### Constants ###
const MOVE_SPEED := 7.5;
const ACCELERATION := 15.0;

const MOUSE_SENS := 0.002;


### Node/Scene Refs ###
@onready var head := $Head;
@onready var interact_cast := $Head/InteractCast;

@onready var flashlight := $Head/Flashlight;
@onready var flashlight_toggle := $Head/Flashlight/Toggle;


func _ready() -> void:
	_capture_mouse();					## Capture the mouse

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("interact"):
		_interaction();
	
	if Input.is_action_just_pressed("flashlight"):
		_flashlight();
	
	## TODO: Replace this with a pause menu.
	if Input.is_action_just_pressed("ui_cancel"):
		_capture_mouse();

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		_mouselook(event);


func _physics_process(delta: float) -> void:
	_movement(delta);
	
	move_and_slide();



#######################
### Physics Process ###
#######################

### Player Movement ###
func _movement(delta: float) -> void:
	var input_vec := Input.get_vector("move_left", "move_right", "move_forward", "move_backward");
	var direction := (transform.basis * Vector3(input_vec.x, 0.0, input_vec.y).normalized()) * MOVE_SPEED;
	
	if velocity.x != direction.x:
		velocity.x = lerp(velocity.x, direction.x, ACCELERATION * delta);
	if velocity.z != direction.z:
		velocity.z = lerp(velocity.z, direction.z, ACCELERATION * delta);



####################
### Normal Input ###
####################

func _interaction() -> void:
	if interact_cast.is_colliding():
		if interact_cast.get_collider() is Interactable:
			interact_cast.get_collider().interact();

func _flashlight() -> void:
	if flashlight.visible:
		flashlight_toggle.play("off");
	else:
		flashlight_toggle.play("on");


#######################
### Unhandled Input ###
#######################

func _mouselook(event: InputEvent) -> void:
	if Input.get_mouse_mode() != Input.MOUSE_MODE_CAPTURED:
		return;
	
	rotate_y(-event.relative.x * MOUSE_SENS);
	
	## TODO: Possibly remove vertical aim for proper doom feel.
	head.rotate_x(-event.relative.y * MOUSE_SENS);
	head.rotation.x = clamp(head.rotation.x, deg_to_rad(-90), deg_to_rad(90));



################
### On Ready ###
################

func _capture_mouse() -> void:
	if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE);
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED);
