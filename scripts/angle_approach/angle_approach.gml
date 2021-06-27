function angle_approach(val, rate, final) {
	final = (final + 360 * 10) mod 360;
	if(rate<0){
		show_error("rate less than 0",true);
	}
	var _180 = abs( angle_difference(val, final) ) == 180;
	var ang_rate = sign( -angle_difference(val, final) ) * rate;
	
	if(_180 and chance(.5)){
		ang_rate = -ang_rate;
	}
	
	return abs( angle_difference(val, final)) > abs(angle_difference(val, val + ang_rate)) ? 
		val + ang_rate : final; //return final or increment
}
