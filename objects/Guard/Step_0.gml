/// @description Guard Movement
if(freeze_check(false)){
	exit;
}

var distract_time = oblivious ? OBL_DELAY : ALT_DELAY;
switch(ai){
	case GuardAI.patrolling:
		spd = WALK_SPD;
		if(alarm[3] == -1){
			if(!path_created or turn_follow_path() and alarm[3] ==-1){
				alarm[3] = distract_time;//set alarm
			}
		}
		break;
	case GuardAI.looking:
	case GuardAI.distracted:
		#region look at distraction before walking to it
		search_stage = 0;
		var goal_dir = point_direction(x, y, gx, gy); 
		dir = angle_approach(dir, DIR_SPD, goal_dir);
		if( angle_equals(dir, goal_dir) ){
			//stare at distraction
			if(!staring){
				staring  = true;
				alarm[0] = distract_time;
			}
		}
		break;
		#endregion
	case GuardAI.investigating:
		//path to goal
		spd = WALK_SPD;
		if( turn_follow_path()){
			ai = GuardAI.searching;
			next_ai = GuardAI.returning;
		}
		break;
	case GuardAI.searching:
		#region Searching
		if(search_stage == 0){//set turn direction
			dir_left  = dir + 89;
			dir_right = dir - 89;
			search_dir = chance(.5);
			search_stage = search_dir ? 1 : 3;
			
		}
		if(search_stage == 1 or search_stage == 3){//turn left
			var dir_goal = search_stage == 1 ? dir_left : dir_right;
			dir = angle_approach(dir, DIR_SPD, dir_goal);
			if(angle_equals(dir, dir_goal)){
				//advance stage and delay
				search_stage++;
				alarm[1] = distract_time;
			}
		}
		if(search_stage == 5){
			ai = next_ai;
			search_stage = 0;
		}
		break;
		#endregion
	case GuardAI.returning:
		//path to patrol
		path_created = false;
		ai = GuardAI.patrolling;
		patrol = instance_distance(x, y, patrola) > instance_distance(x, y, patrolb) ? patrola : patrolb;
		break;
	case GuardAI.alerted:
		//path to goal fast
		spd = MAX_SPD;
		search_stage = 0;
		if(follow_path()){
			search_stage = 0;
			ai = GuardAI.searching;
			next_ai = GuardAI.hunting;
		}
		break;
	case GuardAI.hunting:
		ai = GuardAI.alerted;
		hunt_location();
		break;
	case GuardAI.attacking:
		//fire weapon
		oblivious = false;
		var tx = Thief.x, ty = Thief.y;
		var dis = instance_distance(x,y,Thief);
		var adj = dis / 27;
		tx += adj * Thief.vx;
		ty += adj * Thief.vy;
		search_stage = 0;
		pind = 0;
		//var collide = collision_line_z(x, y, tx, ty, z-1, parSolid, false, false)
		if(see_thief){
			var dir_goal = point_direction(x, y, tx, ty);
			dir = angle_approach(dir, 3, dir_goal);
			if(angle_equals(dir, dir_goal) and can_fire){
				var b = instance_create_depth(x, y, depth-1, Bullet);
				b.image_angle = dir;
				b.gx = tx; b.gy = ty;
				can_fire = false;
				alarm[2] = get_firetime();
			}
		}
		else{
			if(set_path_to_point(Thief.x + Thief.vx, Thief.y + Thief.vy)){
				ai = GuardAI.alerted;
				set_px_py();
			}
		}
		break;
}