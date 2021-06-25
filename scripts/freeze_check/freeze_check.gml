function freeze_check(){//TODO Freeze Animation
	if(global.freeze){
		for(var i = 0; i < 11; i++){
			alarm[i] = alarm[i] + 1;
		}
		return true;
	}
	return false;
}