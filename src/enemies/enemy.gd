class_name Enemy extends CharacterBody3D;

@export var anim_col: int;

### Variables ###
@onready var player: CharacterBody3D = get_tree().get_first_node_in_group("player");


func _process(delta: float) -> void:
	_directional_sprite();


func _physics_process(delta: float) -> void:
	pass;




###############
### Process ###
###############

enum V_FRAMES {FRONT, BACK, LEFT, RIGHT, FRONTLEFT, FRONTRIGHT, BACKLEFT, BACKRIGHT, DEATH, GIB};
enum H_FRAMES {WALK1, WALK2, WALK3, WALK4, FIRE1, FIRE2, HURT};

func _directional_sprite() -> void:
	if !player:
		return;
	
	var p_dir := -global_transform.origin.direction_to(player.global_transform.origin);	## Player Forward
	var fwd := global_transform.basis.z;			## Enemy Forward
	var left := global_transform.basis.x;			## Enemy Left
	
	var f_dot := fwd.dot(p_dir);
	var l_dot := left.dot(p_dir);
	
	var row := 0;
	
	if Input.is_action_just_pressed("debug_trigger"):
		print("F: %s\nL: %s\n" % [f_dot, l_dot]);
	
	if f_dot > 0.85:
		row = V_FRAMES.FRONT;
		
	elif f_dot > 0.15:
		if _p_to_left(l_dot):
			row = V_FRAMES.FRONTRIGHT;
		else:
			row = V_FRAMES.FRONTLEFT
		
	elif f_dot > -.15:
		if _p_to_left(l_dot):
			row = V_FRAMES.RIGHT;
		else:
			row = V_FRAMES.LEFT;
		
	elif f_dot > -0.85:
		if _p_to_left(l_dot):
			row = V_FRAMES.BACKRIGHT;
		else:
			row = V_FRAMES.BACKLEFT
		
	else:
		row = V_FRAMES.BACK;
	
	$Sprite.frame_coords.y = row;

func _p_to_left(l_dot: float) -> bool:
	if l_dot > 0:
		return false;
	else:
		return true;


########################
### Health Functions ###
########################

func hurt(value: int) -> void:
	pass;


#########################
### Setters & Getters ###
#########################
