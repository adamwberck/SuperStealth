/// @description Move with vx and vy
if(freeze_check(true)){
	exit;
}

t++;

var f = z < 0 ? global.AIR_FRIC : global.GRND_FRIC;

var dir = point_direction(0, 0, vx, vy);
var spd =  point_distance(0, 0, vx, vy);

if(!entity_collide(vx, 0)){//check collision in vx 
	x += vx;
}
else{// move to collision
	move_to_collision(vx, 0);
	vx = 0;
	if(fragile){
		instance_destroy();
	}
}
if(!entity_collide(0, vy)){//check collision in vy
	y += vy;
}
else{// move to collision
	move_to_collision(0, vy);
	vy = 0;
	if(fragile){
		instance_destroy();
	}
}

//apply friction
alter_velocity(-min(spd,f),dir);