function entity_collide(vx, vy){
	return place_meeting_z(x + vx, y + vy, z, parSolid) or place_meeting_z(x + vx, y + vy, z, parEntity);
}