/// @description Draw Circle
if(!freeze_check(true)){
	r += SPDR;
}
draw_set_color(c_gray);
draw_set_alpha(sqr(1 - r / MAXR));
draw_circle(x, y, r+2, true);
draw_circle(x, y, r+1, true);
draw_circle(x, y, r, true);
draw_set_alpha(1);
draw_set_color(c_white);
for(var i = 0; i < instance_number(Guard); i++){
	var g = instance_find(Guard, i);
	var dis = instance_distance(x, y, g);
	if(dis < r and !ds_list_contains(dist_gs, g)){
		ds_list_add(dist_gs, g);
		g.gx = x; g.gy = y; 
		g.next_ai = g.ai;
		g.ai = GuardAI.looking;
	}
}
if(r > MAXR){
	if(ds_list_size(dist_gs) > 0){
		Director.comm_sound(dist_gs, x, y);
	}
	instance_destroy();
}