class_name DoorPillar extends Node3D;

@export var key_color: PlayerData.KEY_TYPES;

func unlock() -> void:
	$Sprite.frame = 1;
