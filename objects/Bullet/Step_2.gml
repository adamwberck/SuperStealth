/// @description Move with vx and vy
if(freeze_check(true)){
	exit;
}

t++;

var f = z < 0 ? global.AIR_FRIC : global.GRND_FRIC;

var dir = point_direction(0, 0, vx, vy);
var spd =  point_distance(0, 0, vx, vy);

if(!pos_collide(vx, 0)){//check collision in vx 
	x += vx;
}
else{// destroy
	instance_destroy();
}
if(!pos_collide(0, vy)){//check collision in vy
	y += vy;
}
else{
	instance_destroy();
}

//apply friction
alter_velocity(-min(spd,f),dir);