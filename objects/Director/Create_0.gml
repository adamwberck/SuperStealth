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
	global.diamonds = 0;

	enum GuardAI{
		patrolling,
		distracted,
		looking,
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

function comm_sound(dist_gs, x, y){ //sets closest gaurd to investigate
	var dis_lst = ds_list_create();
	for(var i = 0; i < ds_list_size(dist_gs); i++){
		dis_lst[|i] = instance_distance(x, y, dist_gs[|i]);
	}
	var dis_lst_sort = ds_list_create();
	ds_list_copy(dis_lst_sort, dis_lst);
	ds_list_sort(dis_lst_sort, true);
	var v = dis_lst_sort[|0];//lowest
	
	var g0 = dist_gs[|ds_list_find_index(dis_lst, v)];
	g0.distracted_to_point(x, y);
	ds_list_destroy(dis_lst);
	ds_list_destroy(dis_lst_sort);
}