function freeze_check(delay_alarms){//TODO Freeze Animation
	if(global.freeze){
		if(delay_alarms){
			for(var i = 0; i < 11; i++){
				if(alarm[i]>0){
					alarm[i]++;
				}
			}
		}
		return true;
	}
	return false;
}