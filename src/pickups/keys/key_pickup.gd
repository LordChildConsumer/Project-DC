class_name Key extends Area3D

@export var type: PlayerData.KEY_TYPES;


#
# Pick up the key
#
func _on_body_entered(body: Node3D) -> void:
	if body is Player:
		if type != PlayerData.KEY_TYPES.NONE:
			PlayerData.collect_key(type);
		
		queue_free();
