/// @description Advance Search Stage
if(ai == GuardAI.searching){
	var n = search_dir ? 3 : 1;
	if(search_stage != n + 1)
		search_stage = n;
	else{
		search_stage = 5;
	}
}