#define init
	//global.sprSkillIcon = sprite_add("sprites/Icons/sprSkill" + string_upper(string(mod_current)) + "Icon.png", 1, 12, 16);
	//global.sprSkillHUD  = sprite_add_base64("iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsMAAA7DAcdvqGQAAAC6SURBVDhPnVHBDcIwEMuefPgxBR/erMAkSP10At5ISEwS5Ls4cU5pFWrJysUXO5c2bSAHEiOtgzWfy5rfn68RNfWcG4tWYcL1djfSDA0rNDcqWkg1nM4XY5wAGgNeDwaFAB7c4u4E4Mik9JsbaQa6J7COxIQIAeFxq6MeQIC+nz1wdwJQx9WQ3qxoIfX3waw19xrgNTAIQM3bS3Nugll6iFP0flNW1kDt8/tgFX0ao4C/oLceCgCCOaUfX8/I2KnacDsAAAAASUVORK5CYII=",  1,  8,  8);
	//global.sndSkillSlct = sound_add("sounds/sndMut" + string_upper(string(mod_current)) + ".ogg");

	skill_set_active(mut_trigger_fingers, 0);

#define skill_name    return "STEEL GRAFT";
#define skill_text    return "@wKILLS@s LOWER YOUR @wRELOAD TIME@s#@wBIGGER ENEMIES@s LOWER IT MORE";
#define skill_tip     return "A LIFE OF VIOLENCE";
//#define skill_icon    return global.sprSkillHUD;
//#define skill_button  sprite_index = global.sprSkillIcon;
#define skill_type    return "offensive";
#define skill_take    
	if(array_length(instances_matching(mutbutton, "skill", mod_current)) > 0) {
		sound_play(sndMut);
		//sound_play(global.sndSkillSlct);
	}
	
#define step
    with(instances_matching_le(enemy, "my_health", 0)) { // Find all dead enemies
        if(!variable_instance_exists(self, "steelgraft")) {
            steelgraft = true; // Make sure this only happens once
            var loadreduce = 5 + (15 * (max(size - 1, 0))); // Figure out how big of a bitch this was
            
            with(Player) {
            	gunshine = 7;
                if(reload >= 1) reload = max(reload - floor(loadreduce), -floor(weapon_get_load(wep)));
                if(breload >= 1) breload = max(breload - floor(loadreduce), -floor(weapon_get_load(bwep)));
            }
        }
    }