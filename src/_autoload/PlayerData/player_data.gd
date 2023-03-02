extends Node

################
### PROGRESS ###
################

## TODO: Add level counter and such


#################
### INVENTORY ###
#################

#
# Keys
#

enum KEYS {RED, GREEN, BLUE};

var key_inv: Dictionary = {
	KEYS.RED: false,
	KEYS.GREEN: false,
	KEYS.BLUE: false,
};



## TODO: Make flashlight an actual thing to pick up
var has_flashlight: bool = false;

#
# Weapons
#

enum WEAPONS {MELEE, PISTOL, SHOTGUN, MACHINEGUN, RIFLE, SSG};

var weapon_inv: Dictionary = {
	WEAPONS.MELEE: {
		"has": true,
		"scene": null,
	},
	WEAPONS.PISTOL: {
		"has": false,
		"scene": null,
	},
	WEAPONS.SHOTGUN: {
		"has": false,
		"scene": null,
	},
	WEAPONS.MACHINEGUN: {
		"has": false,
		"scene": null,
	},
	WEAPONS.RIFLE: {
		"has": false,
		"scene": null,
	},
	WEAPONS.SSG: {
		"has": false,
		"scene": null,
	},
};
