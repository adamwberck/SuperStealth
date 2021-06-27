/// @description Director
/*
	Incharge of general game events
*/

#region Set Globals
	global.freeze = true;
	global.size = 32;
	global.sub_room = 9;
	global.AIR_FRIC = .4;
	global.GRND_FRIC = .6;

	enum GuardAI{
		patrolling,
		distracted,
		investigating,
		searching,
		returning,
		alerted,
		attacking,
		hunting
	}

	global.grid = mp_grid_create(-32, -32, (room_width + 32) div global.size, (room_height + 32) div global.size, global.size, global.size);
	mp_grid_add_instances(global.grid, parSolid, false);
#endregion