function pos_collide(vx, vy){
	return position_meeting_z(x + vx, y + vy, z, parSolid);
}