/// @description Guard Movement
if(freeze_check(false)){
	exit;
}

switch(ai){
	case GuardAI.patrol:
		//later
		break;
	case GuardAI.distracted:
		#region look at distraction before walking to it
		search_stage = 0;
		pind = 0;
		var goal_dir = point_direction(x, y, gx, gy); 
		dir = angle_approach(dir, DIR_SPD, goal_dir);
		if(dir == goal_dir){
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
		turn_follow_path();
		break;
	case GuardAI.searching:
		qdbug(search_stage);
		if(search_stage == 0){//set turn direction
			dir_left  = dir + 89;
			dir_right = dir - 89;
			search_stage = 1;
			
		}
		if(search_stage == 1 or search_stage == 3){//turn left
			var dir_goal = search_stage == 1 ? dir_left : dir_right;
			dir = angle_approach(dir, DIR_SPD, dir_goal);
			if(dir == dir_goal){
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
	case GuardAI.returning:
		//path to patrol
		break;
	case GuardAI.alerted:
		//path to goal fast!
		break;
	case GuardAI.attacking:
		//fire weapon
		break;
}