/// @description Draw Circle Comms
if(!freeze_check(true)){
	r += SPDR;
}
draw_set_color(c_green);
draw_set_alpha(sqr(1 - r / MAXR));
draw_circle(x, y, r+2, true);
draw_circle(x, y, r+1, true);
draw_circle(x, y, r, true);
draw_set_alpha(1);
draw_set_color(c_white);
for(var i = 0; i < instance_number(Guard); i++){
	var g = instance_find(Guard, i);
	var dis = instance_distance(x, y, g);
	if(g != my_guard and dis < r and !ds_list_contains(dist_gs, g)){
		ds_list_add(dist_gs, g);
		if(distracted_to_point(b.gx, b.gy)){
			g.oblivious = false;
		}
	}
}

if(r > MAXR){
	instance_destroy();
}