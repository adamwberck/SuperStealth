/// @description Draw Self and Path
draw_self();
draw_path(path, x, y, true);
draw_set_color(c_purple);
draw_rectangle(px-4,py-4,px+4,py+4,false);
draw_set_color(c_white);

#region draw_flashlight
	var angle = 20;
	var dis = 200;
	var map = ds_map_create();
	var len = dis;
	var thief = false;
	for(var a = dir - angle; a <= dir + angle; a++){
		map[?a] = flash_light_col(len, 0, dis, a);
		len = map[?a];
		thief = thief or collision_line(x, y, x + lengthdir_x(len, a), 
											  y + lengthdir_y(len, a), 
										 Thief, false, false) != noone;
	}
	draw_set_alpha(0.4);
	draw_set_color(thief ? c_red : c_yellow);
	for(var a = dir - angle; a < dir + angle; a++){
		var b = a + 1;
		draw_triangle(x, y, x + lengthdir_x(map[?a], a), y + lengthdir_y(map[?a], a),
							x + lengthdir_x(map[?b], b), y + lengthdir_y(map[?b], b), false);
	}
	draw_set_color(c_white);
	draw_set_alpha(1.0);
#endregion