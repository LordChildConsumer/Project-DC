class_name Interactable extends Area3D;

### Exports ###
@export var one_shot: bool = false;
@export var locked: bool = false;

### Variables ###
var can_interact: bool = true;


### This function will be called by the player script ###
func interact() -> void:
	if !locked && can_interact:
		_activate();
	else:
		return;


### This function should be overridden by extensions of this class ###
func _activate() -> void:
	pass;
