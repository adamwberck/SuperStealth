/// @description Define Functions
path = path_add();
patrola = patrol_a;//debug
patrolb = patrol_b;//debug
patrol  = patrola;//set patrol to patrola
gx = x; gy = y;

memory_x = ds_list_create();
memory_y = ds_list_create();
memory_t = ds_list_create();

function get_firetime(){
	static num = -1;
	num = (num + 1) mod 3;
	switch(num){
		case 0:
		case 1:
			return 5;
		case 2:
			return 15;
	}
}

function set_path_to_point(x1, y1){
	gx = x1; gy = y1;
	path_created = mp_grid_path(global.grid, path, x, y, x1, y1, true);
	return path_created;
}

function turn_follow_path(){
	var goal_dir = point_direction(x, y, px, py);
	dir = angle_approach(dir, DIR_SPD, goal_dir);
	if(dir == goal_dir){
		x = px; y = py;
		return set_px_py();//true if end of path
	}
	return false;
}

function follow_path(){
	var goal_dir = point_direction(x, y, px, py);
	dir = angle_approach(dir, DIR_SPD, goal_dir);
	x = px; y = py;
	return set_px_py();//true if end of path
}



function set_px_py(){// set px and py returns true if at end of path
	var len = path_get_length(path);
	pind += spd;
	var pos = min(1, pind / len);
	px = path_get_x(path, pos);
	py = path_get_y(path, pos);
	return pos >= 1;
}

function flash_light_col(start, _min, _max, angle){
	for(var i = start; i >= _min; i--){// go backwards to find the closest
		var collision = collision_line(x, y, x + lengthdir_x(i, angle), 
										 y + lengthdir_y(i, angle), 
										 parSolid, false, false) != noone;
		if(!collision){
			start = i;
			break;
		}
	}
	for(var i = start; i <= _max; i++){//return the furthest
		var collision = collision_line(x, y, x + lengthdir_x(i, angle), 
										 y + lengthdir_y(i, angle), 
										 parSolid, false, false) != noone;

		if(collision){
			return i-1;
		}
	}
	return _max;
}