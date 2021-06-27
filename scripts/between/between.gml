// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function between(val, low, high){
	if(low>high){
		show_error("func between: low greater than high", true);
	}
	return val > low and val < high;
}