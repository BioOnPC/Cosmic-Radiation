#define init
	//global.sprSkillIcon = sprite_add("sprites/Icons/sprSkill" + string_upper(string(mod_current)) + "Icon.png", 1, 12, 16);
	//global.sprSkillHUD  = sprite_add("sprites/HUD/sprSkill" + string_upper(string(mod_current)) + "HUD.png",  1,  8,  8);
	//global.sndSkillSlct = sound_add("sounds/sndMut" + string_upper(string(mod_current)) + ".ogg");

#define skill_name    return "AUXILIARY LIMB";
#define skill_text    return "RAPID @wSECONDARY WEAPON@s RELOAD";
#define skill_tip     return "EXTREME MULTITASKING";
//#define skill_icon    return global.sprSkillHUD;
//#define skill_button  sprite_index = global.sprSkillIcon;
#define skill_take    
	if(array_length(instances_matching(mutbutton, "skill", mod_current)) > 0) {
		sound_play(sndMut);
	}
	
#define step
	with(Player) {
		if(breload > 0) breload -= current_time_scale * (1.25 + (skill_get(mod_current) * 0.25));
	}
	
