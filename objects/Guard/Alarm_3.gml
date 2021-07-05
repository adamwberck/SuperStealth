/// @description continue patrol
if(ai == GuardAI.patrolling){
	patrol = patrol == patrola ? patrolb : patrola; 
	set_path_to_point(patrol.x, patrol.y);
	pind = 0;
	set_px_py();//set px and py
}