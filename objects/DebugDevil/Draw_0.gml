/// @description Don't
if(drawValues){
	draw_set_halign(fa_center);
	draw_set_font(DebugFont);
	var arr = value;
	draw_set_color(c_white);
	for(var j=1;j<=10;j++){
		var i = j mod 10;
		draw_text(x,y+j*30,string(i)+" "+string_format(arr[i], 3, 3));
	}
}