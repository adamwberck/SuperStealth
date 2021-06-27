/// @description Define Functions
path = path_add();
patrola = patrol_a;//debug
patrolb = patrol_b;//debug
patrol  = patrola;//set patrol to patrola
gx = x; gy = y;

memory_x = ds_list_create();
memory_y = ds_list_create();
memory_t = ds_list_create();


function mem_t_frac(index){
	return max( 0, (MEMORY_FADE - t + memory_t[|index]) / MEMORY_FADE); 
}

function hunt_location(){
	var p_c = false;
	var r = 9;//furthest hunt
	var c = 3;//too close hunt
	var k = 0;
	var s = global.size;
	var w = room_width, h = room_height;
	#region random next hunt place
	while(!p_c){
		var sx = floor(x / s), sy = floor(y / s);
		var lx = max( -sx, -r), hx = min(  ( (w-x) div s),  r);//random square close but in range
		var ly = max( -sy, -r), hy = min(  ( (h-y) div s),  r);
		if(chance(.5)){
			var rx = sx + irandom_range_ex(lx, hx, c), ry = sy + irandom_range(ly, hy);
		}
		else{
			var rx = sx + irandom_range(lx, hx), ry = sy + irandom_range_ex(ly, hy, c);
		}
		rx = rx * s + s div 2; ry = ry * s + s div 2;
		var index = ds_lists_find_index(memory_x, rx, memory_y, ry);
		var t_frac = index == -1 ? 0 : mem_t_frac(index);
		if(t_frac <= k ){
			p_c = set_path_to_point(rx, ry);
		}
		k += .01;
	}
	#endregion
	pind = 0;
	set_px_py();//set px and py
}


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
	pind = 0;
	path_created = mp_grid_path(global.grid, path, x, y, x1, y1, true);
	return path_created;
}

function turn_follow_path(){
	var goal_dir = point_direction(x, y, px, py);
	dir = angle_approach(dir, DIR_SPD, goal_dir);
	if(angle_equals(dir, goal_dir)){
		x = px; y = py;
		return set_px_py();//true if end of path
	}
	return false;
}

function follow_path(){
	var goal_dir = point_direction(x, y, px, py);
	dir = angle_approach(dir, DIR_SPD, goal_dir);
	x = px; y = py;
	return  set_px_py() and angle_equals(dir, goal_dir);//true if end of path
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
		var collision = collision_line_z(x, y, x + lengthdir_x(i, angle), 
										y + lengthdir_y(i, angle), z - 1,
										parSolid, false, false);
		if(!collision){
			start = i;
			break;
		}
	}
	for(var i = start; i <= _max; i++){//return the furthest
		var collision = collision_line_z(x, y, x + lengthdir_x(i, angle), 
										y + lengthdir_y(i, angle), z - 1, 
										parSolid, false, false);

		if(collision){
			return i-1;
		}
	}
	return _max;
}