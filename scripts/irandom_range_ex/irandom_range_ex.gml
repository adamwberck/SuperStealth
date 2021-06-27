//returns a random int from x1 to x2 except between -ex and ex
function irandom_range_ex(x1, x2, ex){
	var l = ds_list_create();
	for(var i = x1; i <= x2 ; i++){
		if(!between(i, -ex-.1, ex+.1)){
			ds_list_add(l,i);
		}
	}
	ds_list_shuffle(l);
	var r = l[|0];
	if(is_undefined(r)){
		//show_error("nothing in range",true);
		ds_list_destroy(l);
		return irandom_range(x1, x2);
	}
	ds_list_destroy(l);
	return r;
}