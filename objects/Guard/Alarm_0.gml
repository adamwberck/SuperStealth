/// @description Switch to travel
staring = false;
if(ai == GuardAI.distracted){//go and investigate
	ai = oblivious ? GuardAI.investigating : GuardAI.alerted;
	pind = 0;
	set_px_py();
}
else {
	ai = next_ai;
}