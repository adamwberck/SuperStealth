/// @description Guard Movement
if(freeze_check(false)){
	exit;
}

switch(ai){
	case GuardAI.patrol:
		spd = WALK_SPD;
		if(!path_created or turn_follow_path()){
			patrol = patrol == patrola ? patrolb : patrola; 
			set_path_to_point(patrol.x, patrol.y);
			pind = 0;
			set_px_py();//set px and py
		}
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
		#endregion
	case GuardAI.returning:
		//path to patrol
		path_created = false;
		ai = GuardAI.patrol;
		break;
	case GuardAI.alerted:
		//path to goal fast
		spd = MAX_SPD;
		if(follow_path()){
			search_stage = 0;
			ai = GuardAI.searching;
			next_ai = GuardAI.hunting;
		}
		break;
	case GuardAI.attacking:
		//fire weapon
		var tx = Thief.x, ty = Thief.y;
		var dis = instance_distance(x,y,Thief);
		var adj = dis / 27;
		tx += adj * Thief.vx;
		ty += adj * Thief.vy;
		search_stage = 0;
		pind = 0;
		var collide = collision_line(x, y, tx, ty, parSolid, false, false) != noone;
		if(!collide and (dis < 200) ){
			var dir_goal = point_direction(x, y, tx, ty);
			dir = angle_approach(dir, 3, dir_goal);
			if(dir == dir_goal and can_fire){
				var b = instance_create_depth(x, y, depth-1, Bullet);
				b.image_angle = dir;
				can_fire = false;
				alarm[2] = get_firetime();
			}
		}
		else{
			set_path_to_point(Thief.x + Thief.vx, Thief.y + Thief.vy);
			ai = GuardAI.alerted;
			set_px_py();
		}
		break;
}