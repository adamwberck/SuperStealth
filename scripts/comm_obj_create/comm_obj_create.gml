function comm_obj_create(x, y, my_guard, gx, gy){
	var c = instance_create(x, y, CommObj);
	c.my_guard = id;
	c.gx = Thief.x;
	c.gy = Thief.y;
}