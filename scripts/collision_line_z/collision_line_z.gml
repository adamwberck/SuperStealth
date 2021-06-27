function collision_line_z(x1, y1, x2, y2, z, obj, prec, notme){
	var list = ds_list_create();
	collision_line_list(x1, y1, x2, y2, obj, prec, notme, list, false);
	for(var i = 0; i < ds_list_size(list); i++){
		if(list[|i].tall or z == list[|i].z){
			ds_list_destroy(list);
			return true;
		}
	}
	ds_list_destroy(list);
	return false;
}