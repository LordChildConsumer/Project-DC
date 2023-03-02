class_name Weapon extends Node3D;

### Exports ###
@export var damage: int = 5;
@export var ammo_type: PlayerData.AMMO_TYPES;
@export var ammo_cost: int = 1;

### Node/Scene Refs ###
@onready var raycasts := $Bullets;
@onready var anim := $AnimationPlayer;


### Variables ###
var can_shoot: bool = true;


func _input(event: InputEvent) -> void:
	if Input.is_action_pressed("shoot_primary") && can_shoot:
		
		## TODO: Implement ammo/counter
		if !PlayerData.ammo[ammo_type] > 0:
			return;
		
		PlayerData.spend_ammo(ammo_type, ammo_cost);
		
		can_shoot = false;
		anim.play("shoot");
		
		## Actually shoot
		for c in raycasts.get_children():
			if c.is_colliding():
				if c.get_collider() is Enemy:
					c.hurt(damage);
				else:
					## TODO: Summon bullet smoke thingies
					pass;
		
		## Reenable shooting
		await anim.animation_finished;
		can_shoot = true;
