function move_to_collision(vx , vy){
	var sx = sign(vx), var sy = sign(vy);
	while(!entity_collide(sx,sy)){
		x += sx;
		y += sy;
	}
}