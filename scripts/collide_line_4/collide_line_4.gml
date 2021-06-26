function collide_line_4(px, py){
	var s = global.size;
	fx = floor_to_n(px, s);
	fy = floor_to_n(py, s);
	var tl = collision_line( bbox_left + 1 , bbox_top    + 1, fx    , fy    , parSolid, false, false) != noone;
	var tr = collision_line( bbox_right - 1, bbox_top    + 1, fx + s, fy    , parSolid, false, false) != noone;
	var bl = collision_line( bbox_left + 1 , bbox_bottom - 1, fx    , fy + s, parSolid, false, false) != noone;
	var br = collision_line( bbox_right - 1, bbox_bottom - 1, fx + s, fy + s, parSolid, false, false) != noone;
	return tl or tr or bl or br;
}