function place_meeting_z(x, y, z, obj){
	var inst = instance_place(x,y,obj); //replace with list?
	return instance_exists(inst) and (inst.tall or z == inst.z);
}

function position_meeting_z(x, y, z, obj){
	var inst = instance_position(x,y,obj);
	return instance_exists(inst) and (inst.tall or z == inst.z);
}