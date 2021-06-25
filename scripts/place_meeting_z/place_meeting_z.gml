function place_meeting_z(x, y, z, obj){
	var inst = instance_place(x,y,obj); //replace with list?
	return instance_exists(inst) and (inst.tall or z == inst.z);
}