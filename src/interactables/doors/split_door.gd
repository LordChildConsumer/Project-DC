extends Interactable


func _activate() -> void:
	can_interact = false;
	$AnimationPlayer.play("open");
	$AutoClose.start();




func _on_auto_close_timeout() -> void:
	$AnimationPlayer.play("close");
	await $AnimationPlayer.animation_finished;
	can_interact = true;
