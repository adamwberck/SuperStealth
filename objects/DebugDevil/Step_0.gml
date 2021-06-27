/// @description NumMode

for(var i=0;i<10;i++){
	var key = keyboard_check_pressed(ord("`")) or keyboard_check_pressed(ord(string(i)));
	if(key==ord("`")) then key=ord("0");
	var tsign = keyboard_check(vk_shift) ? -key : key ;
	value[i] += RATE*tsign;
}

if(keyboard_check(vk_alt)){
	x+=10*(keyboard_check(vk_right)-keyboard_check(vk_left));
	y+=10*(keyboard_check(vk_down)-keyboard_check(vk_up));
}