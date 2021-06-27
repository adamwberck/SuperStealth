function ds_lists_contains(l1, v1, l2, v2){
	for(var i=0; i<ds_list_size(l1); i++){
		if(l1[|i]==v1 and l2[|i]==v2){
			return true;
		}
	}
	return false;
}

function ds_lists_find_index(l1, v1, l2, v2){
	var qc = ds_list_find_index(l1,v1);
	if(qc != -1 and l2[|qc] == v2){
		return qc;
	}
	for(var i=0; i<ds_list_size(l1); i++){
		if(l1[|i]==v1 and l2[|i]==v2){
			return i;
		}
	}
	return -1;
}