//dir dir_spd dir_anti dir_goal ACCEL DCCEL
function slow_rotate(){
	var dir_anti = sign( -angle_difference(dir, dir_goal));
	if(dir_anti == 0){
		return;
	}
	var a_dif = abs(angle_difference(dir, dir_goal));//p2
	var stop_dist = 0, v = abs(dir_spd);
	while( v > 0){
		v = approach(v, DIR_ACCEL, 0);
		stop_dist += v;
	}
	#region turn
	
	if(sign(dir_spd) != dir_anti or stop_dist < a_dif and a_dif > 0){//speed up
		dir_spd = approach(dir_spd, DIR_ACCEL , DIR_MAX * dir_anti);
		qdbug(string(stop_dist-a_dif) + "T " + string(dir_spd));
	}
	else{//slow down
		dir_spd = approach(dir_spd, DIR_ACCEL , 0);
		qdbug(string(stop_dist-a_dif) + "S " + string(dir_spd));
	}
	dir += dir_spd;//angle_approach(dir, dir_spd, dir_goal);
	dir = dir + 360 mod 360; dir_goal = dir_goal + 360 mod 360
	if(abs(angle_difference(dir, dir_goal)) < dir_spd){
		dir = dir_goal;
		dir_spd = 0;
	}
	#endregion
} 