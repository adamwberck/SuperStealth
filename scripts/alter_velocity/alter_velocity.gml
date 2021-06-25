function alter_velocity(change, dir){
	vx += lengthdir_x(change, dir);
	vy += lengthdir_y(change, dir);
	var spd = point_distance (0, 0, vx, vy);
	dir = point_direction(0, 0, vx, vy);
	if(spd > MAX_SPD){
		vx = lengthdir_x(MAX_SPD, dir);
		vy = lengthdir_y(MAX_SPD, dir);
	}
}