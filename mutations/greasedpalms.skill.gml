#define init


#define skill_name    return "GREASED PALMS";
#define skill_text    return "@wCHESTS@s SPAWN @wTEMPORARY BUBBLES@s#@wBUBBLES@s INCREASE @wRELOAD SPEED@s";
#define skill_tip     return "SLICK TRICKS";
#define skill_take    
	if(array_length(instances_matching(mutbutton, "skill", mod_current)) > 0) {
		sound_play(sndMut);
	}
	
#define step

#define obj_create(_x, _y, _name)   return  mod_script_call("mod", "mutmod", "obj_create", _x, _y, _name);