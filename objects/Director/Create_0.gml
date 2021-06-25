/// @description Director
/*
	Incharge of general game events
*/

#region Set Globals
	global.freeze = true;
	global.size = 32;
	global.sub_room = 5;
	global.AIR_FRIC = .4;
	global.GRND_FRIC = .6;

	enum GuardAI{
		patrol,
		interested,
		returning,
		alerted,
		attacking
	}

#endregion