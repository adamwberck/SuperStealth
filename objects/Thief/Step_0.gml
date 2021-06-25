/// @description Movement
var k_left  = keyboard_check(ord("A"));
var k_right = keyboard_check(ord("D"));
var k_up    = keyboard_check(ord("W"));
var k_down  = keyboard_check(ord("S"));
var k_go    = keyboard_check(vk_space);

var x_mov = k_right - k_left;
var y_mov = k_down - k_up;
global.freeze = !k_go and x_mov == 0 and y_mov == 0;
if(x_mov != 0 or y_mov != 0)
	alter_velocity(ACCEL, point_direction(0, 0, x_mov, y_mov) );