/// @description 
qdbug(global.diamonds++)
var rx = center_cords(random(room_width));
var ry = center_cords(random(room_height));
while(place_meeting(rx, ry, parSolid)){
	rx = center_cords(random(room_width));
	ry = center_cords(random(room_height));
}
instance_create(rx, ry, Diamond);
instance_destroy();