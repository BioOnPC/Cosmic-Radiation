#define init
	global.sprIcon = sprite_add("../sprites/sprChangeCrownReroll.png", 1, 12, 16);

#define skill_name    return "REROLL";
#define skill_text    return "@wREROLL@s THESE MUTATIONS";
#define skill_tip     return "";
#define skill_button  sprite_index = global.sprIcon;
#define skill_avail   return false; // 

#define skill_take
    if(array_length(instances_matching(mutbutton, "skill", mod_current)) > 0) {
		sound_play(sndMut);
		sound_play_pitch(sndHorrorPortal, 1.4 + random(0.2));
		sound_play_pitch(sndStatueCharge, 0.8 + random(0.2));
		
		with(GameCont) skillpoints++;
		
		mod_variable_set("crown", "change", "reroll_avail", false);
		
		if(fork()) {
		    wait 0;
		    mod_variable_set("crown", "change", "reroll_avail", false);
		    exit;    
		}
    }
	
	skill_set(mod_current, 0);