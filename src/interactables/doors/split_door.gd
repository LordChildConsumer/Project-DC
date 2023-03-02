extends Interactable

@export var key_color: PlayerData.KEY_TYPES;


func _ready() -> void:
	if key_color != PlayerData.KEY_TYPES.NONE:
		locked = true;


## Unlock the door when key is picked up
func unlock() -> void:
	locked = false;


func _activate() -> void:
	can_interact = false;
	$AnimationPlayer.play("open");
	$AutoClose.start();


func _on_auto_close_timeout() -> void:
	$AnimationPlayer.play("close");
	await $AnimationPlayer.animation_finished;
	can_interact = true;
