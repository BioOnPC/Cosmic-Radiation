#define init
	global.sprSkillIcon = sprite_add("sprites/Icons/sprSkill" + string_upper(string(mod_current)) + "Icon.png", 1, 12, 16);
	global.sprSkillHUD  = sprite_add("sprites/HUD/sprSkill" + string_upper(string(mod_current)) + "HUD.png",  1,  8,  8);
	global.sndSkillSlct = sound_add("sounds/sndMut" + string_upper(string(mod_current)) + ".ogg");

#define skill_name    return "CAMOUFLAGE";
#define skill_text    return "@wENEMIES@s ACT @wSLOWER";
#define skill_tip     return "HARD TO PIN DOWN";
#define skill_icon    return global.sprSkillHUD;
#define skill_button  sprite_index = global.sprSkillIcon;
#define skill_take    
	if(array_length(instances_matching(mutbutton, "skill", mod_current)) > 0) {
		sound_play(sndMut);
		sound_play(global.sndSkillSlct);
	}
	
#define step
	with(enemy){
		if "camoalrm0" not in self {
			camoalrm0 = 0;
		}
		if "camoalrm1" not in self {
			camoalrm1 = 0;
		}
		if "alrm0" not in self {
			alrm0 = 0;
		}
		if "alrm1" not in self {
			alrm1 = 0;
		}
		
		
		if camoalrm0 < alrm0 || camoalrm0 < alarm0 {
			camoalrm0 = max(alrm0, alarm0)
		}
		if camoalrm0 > 0 && (alrm0 <= current_time_scale || alarm0 <= current_time_scale) {
			repeat(skill_get(mod_current)){
				if irandom(5) < 1 {
					alrm0 = camoalrm0;
					alarm0 = camoalrm0;
				}
			}
			if alrm0 == camoalrm0 && alarm0 == camoalrm0 {
				instance_create(x, y, AssassinNotice).depth = depth - 1;
				sound_play_pitchvol(sndImpWristHit, 1.4 + random(0.4), 1);
				sound_play_pitchvol(sndDragonStart, 2 + random(0.4), 0.4);
			}
		}
		
		if camoalrm1 < alrm1 || camoalrm1 < alarm1 {
			camoalrm1 = max(alrm1, alarm1)
		}
		if camoalrm1 > 0 && (alrm1 <= current_time_scale || alarm1 <= current_time_scale) {
			if(object_index != Van) {
				repeat(skill_get(mod_current)){
					if irandom(5) < 1 {
						alrm1 = camoalrm1;
						alarm1 = camoalrm1;
					}
				}
			}
			if alrm1 == camoalrm1 && alarm1 == camoalrm1 {
				instance_create(x, y, AssassinNotice).depth = depth - 1;
				sound_play_pitchvol(sndImpWristHit, 1.4 + random(0.4), 1);
				sound_play_pitchvol(sndDragonStart, 2 + random(0.4), 0.4);
			}
		}
	}
	
	with(Player) {
		if(random(10) < 1) {
			repeat(irandom_range(1, 3)) {
				instance_create(x, y, Feather).sprite_index = sprLeaf;
			}
			
			if(!audio_is_playing(sndJungleAssassinWake)) sound_play_pitchvol(sndJungleAssassinWake, 1.8 + random(0.6), 0.08);
		}
	}