/// @description Draw Self and Path
image_blend = oblivious ? c_white: c_red;
draw_self();
draw_path(path, x, y, true);
draw_set_color(c_purple);
draw_rectangle(gx-4,gy-4,gx+4,gy+4,false);
draw_set_color(c_white);

#region draw_flashlight
	var angle = 20;
	var dis = 200;
	var notice = 10;
	var map = ds_map_create();
	var len = dis;
	var thief = false;
	var notice_thief = false
	for(var a = dir - angle; a <= dir + angle; a++){
		map[?a] = flash_light_col(len, 0, dis, a);
		len = map[?a];
		var c_l = collision_line_z(x, y, x + lengthdir_x(len, a), y + lengthdir_y(len, a), z, Thief, false, false);
		if (between(a, dir - notice, dir + notice)){
			thief = thief or c_l;
			if(false and oblivious){//seeing a bullet alerts you
				var b = collision_line(x, y, x + lengthdir_x(len, a), y + lengthdir_y(len, a), Bullet, false, false);
				if(b != noone and set_path_to_point(b.gx, b.gy)){
					oblivious = false;
					ai = GuardAI.distracted;
				}
			}
		}
		else{
			notice_thief = notice_thief or c_l;
		}
	}
	draw_set_alpha(0.2);
	for(var a = dir - angle; a < dir + angle; a++){
		var b = a + 1;
		
		var color = between(a, dir - notice, dir + notice) ? c_yellow : c_ltgray;
		draw_set_color(thief ? c_red : color);
		var x2 = x + lengthdir_x(map[?a], a);
		var y2 = y + lengthdir_y(map[?a], a);
		var x3 = x + lengthdir_x(map[?b], b);
		var y3 = y + lengthdir_y(map[?b], b);
		draw_triangle(x, y, x2, y2, x3, y3, false);
		var cap_len = max(map[?a], map[?b]); 
		var cap_x = x + lengthdir_x( cap_len, a), s = global.size;
		var cap_y = y + lengthdir_y( cap_len, a);
		#region rember what you have seen
		if(!freeze_check(false)){
			for(var i = center_cords(x); i != cap_x; i = approach(i, s, cap_x) ){
				for(var j = center_cords(y); j != cap_y; j = approach(j, s, cap_y) ){
					if(point_in_triangle(i, j, x, y, x2, y2, x3, y3)){
						var index = ds_lists_find_index(memory_x, i, memory_y, j);
						if(index == -1){
							ds_list_add(memory_x, i);
							ds_list_add(memory_y, j);
							ds_list_add(memory_t, t);
						}
						else{
							memory_t[|index] = t;//update time
						}
					}
					//qdbug(string(k++) + " | " + string(i)+" "+string(j));
				}
			}
		}
		#endregion
	}
	see_thief = thief or (notice_thief and see_thief);
	if(thief and ai != GuardAI.attacking){
		ai = GuardAI.attacking;
		//comm_obj_create(x, y, id, Thief.x, Thief.y);
	}
	if(thief){
		draw_set_color(c_red);
		draw_set_alpha(.6);
		draw_line_width(x, y, x + lengthdir_x(map[?dir], dir), y + lengthdir_y(map[?dir], dir), 3);
	}

	draw_set_color(c_green);
	for(var i=0; i < ds_list_size(memory_x); i++){
		var xx = memory_x[|i];
		var yy = memory_y[|i];
		draw_set_alpha(mem_t_frac(i));
		draw_rectangle(xx - 2, yy - 2, xx + 2, yy + 2, false);
	}
	
	draw_set_color(c_white);
	draw_set_alpha(1.0);
#endregion

ds_map_destroy(map);