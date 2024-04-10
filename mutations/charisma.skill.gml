#define init
	//global.sprSkillIcon = sprite_add("sprites/Icons/sprSkill" + string_upper(string(mod_current)) + "Icon.png", 1, 12, 16);
	//global.sprSkillHUD  = sprite_add("sprites/HUD/sprSkill" + string_upper(string(mod_current)) + "HUD.png",  1,  8,  8);
	//global.sndSkillSlct = sound_add("sounds/sndMut" + string_upper(string(mod_current)) + ".ogg");
	
	global.level_start = false
	
#define skill_name    return "CHARISMA";
#define skill_text    return "@wBIG ENEMIES@s SOMETIMES BECOME @wFAKES@s#@wFAKES@s CONTAIN @wALLIES@s";
#define skill_tip     return "FRIENDS IN STRANGE PLACES";
//#define skill_icon    return global.sprSkillHUD;
//#define skill_button  sprite_index = global.sprSkillIcon;
#define skill_take    
	if(array_length(instances_matching(mutbutton, "skill", mod_current)) > 0) {
		sound_play(sndMut);
	}
	
#define step
	if(instance_exists(GenCont) || instance_exists(Menu)){
		global.level_start = true;
	}
	
	else if(global.level_start) {
		global.level_start = false;
		
		var big_enemy = instances_matching_ge(enemy, "size", 2),
			enemy_pool = ceil((array_length(big_enemy) * 0.25) + GameCont.loops);
			
		trace(enemy_pool);
		
		with(big_enemy) {
			if("intro" not in self && enemy_pool > 0) {
				with(call(scr.obj_create, x, y, "Fake")) {
					spr_idle		= other.spr_idle;
					spr_walk		= other.spr_walk;
					spr_hurt		= other.spr_hurt;
					spr_dead		= other.spr_dead;
					spr_shadow		= other.spr_shadow;
					
					sprite_index	= spr_idle;
					
					team			= other.team;
					size			= other.size;
				}
				
				enemy_pool--;
				
				instance_delete(self);
			}
		}
	}
	
#macro  scr																						mod_variable_get("mod", "cosmic radiation", "scr")
#macro  call																					script_ref_call