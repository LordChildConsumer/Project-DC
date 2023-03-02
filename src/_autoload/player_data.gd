extends Node

######################
##     PROGRESS     ##
######################

## TODO: Add level counter and such


#######################
##     INVENTORY     ##
#######################

############
### KEYS ###
############

signal key_inventory_changed;

enum KEY_TYPES {NONE, RED, BLUE, YELLOW};

var keys: Dictionary = {
	KEY_TYPES.RED: false,
	KEY_TYPES.BLUE: false,
	KEY_TYPES.YELLOW: false,
};

## TODO: Collecting Keys.
func collect_key(type: KEY_TYPES) -> void:
	if type in keys:
		keys[type] = true;
		
		## Unlock all doors.
		for i in get_tree().get_nodes_in_group("door"):
			print("Door found")
			if type == i.key_color:
				print("Unlocking")
				i.unlock();
	
	
	
	key_inventory_changed.emit();

func reset_keys() -> void:
	for k in keys:
		keys[k] = false;
		
		key_inventory_changed.emit();

###############
### WEAPONS ###
###############

signal weapon_inventory_changed;

enum WEAPON_TYPES {NONE, MELEE, FLASHLIGHT, PISTOL, SHOTGUN, MACHINEGUN, RIFLE, SSG};

## TODO: Make flashlight an actual thing to pick up
var has_flashlight: bool = false;

## TODO: Make weapon scenes
var weapons: Dictionary = {
	WEAPON_TYPES.MELEE: {
		"has": true,
		"scene": null,
	},
	WEAPON_TYPES.PISTOL: {
		"has": false,
		"scene": null,
	},
	WEAPON_TYPES.SHOTGUN: {
		"has": false,
		"scene": null,
	},
	WEAPON_TYPES.MACHINEGUN: {
		"has": false,
		"scene": null,
	},
	WEAPON_TYPES.RIFLE: {
		"has": false,
		"scene": null,
	},
	WEAPON_TYPES.SSG: {
		"has": false,
		"scene": null,
	},
};

## TODO: Implement weapon pickups
func collect_weapon(type: WEAPON_TYPES) -> void:
	## Code here.
	
	weapon_inventory_changed.emit();

#############
### ITEMS ###
#############

signal item_inventory_changed;

enum ITEM_TYPES {NONE, HEALTH, ARMOR, AMMO};

### Ammo ###

enum AMMO_TYPES {NONE, BULLET, SHELL, EXPLOSIVE, SPECIAL};

var MAX_AMMO: Dictionary = {
	AMMO_TYPES.BULLET: 200,
	AMMO_TYPES.SHELL: 100,
	AMMO_TYPES.EXPLOSIVE: 50,
	AMMO_TYPES.SPECIAL: 25,
};

## TODO: Set these all to 0. 99 is for testing purposes
var ammo: Dictionary = {
	AMMO_TYPES.BULLET: 99,
	AMMO_TYPES.SHELL: 99,
	AMMO_TYPES.EXPLOSIVE: 99,
	AMMO_TYPES.SPECIAL: 99,
};


func collect_ammo(type: AMMO_TYPES, amount: int) -> void:
	ammo[type] = min(ammo[type] + amount, MAX_AMMO[type]);
	item_inventory_changed.emit();

func spend_ammo(type: AMMO_TYPES, amount: int) -> void:
	ammo[type] = max(ammo[type] + amount, 0);
	item_inventory_changed.emit();
