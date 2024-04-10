#define init
    global.sprIcon = sprite_add("../sprites/sprChangeCrownIcon.png", 1, 12, 16);
    global.sprIdle = sprite_add("../sprites/sprChangeCrownIdle.png", 1, 8, 8);
    global.sprWalk = sprite_add("../sprites/sprChangeCrownWalk.png", 6, 8, 8);
    global.reroll_avail = true;

#define crown_name        return "CROWN OF CHANGE";
#define crown_text        return "-1 @gMUTATION@s CHOICE#@wREROLL@s YOUR MUTATION CHOICES";
#define crown_tip         return ["MAKE THE INTERESTING CHOICE", "THERE IS ALWAYS SOMETHING BETTER"];
#define crown_button      sprite_index = global.sprIcon;
#define crown_avail       return (instance_exists(GameCont) && GameCont.loops = 0);

#define crown_take
    if(array_length(instances_matching(mutbutton, "crown", mod_current)) > 0) {
		sound_play(sndMenuCrown);
		sound_play(sndLevelUp);
		sound_play(sndHorrorPortal);
	}

#define crown_object
    spr_idle = global.sprIdle;
    spr_walk = global.sprWalk;
    
#define step
    script_bind_end_step(crown_end_step, 0);
    
    with(instances_matching(LevCont, "change_crown", null)) {
        change_crown = true;
        global.reroll_avail = true;
    }


#define crown_end_step
    if(instance_number(SkillIcon) > 1 and array_length(instances_matching(SkillIcon, "change_crown", null))) {
        var _last = false;
        with(instances_matching(SkillIcon, "change_crown", null)) {
            change_crown = true;
            
            if(num = instance_number(SkillIcon) - 1 and !_last) {
                if(global.reroll_avail) {
                    with(instance_create(0, 0, SkillIcon)) {
                        change_crown = true; // Prevent the -1 mutation choice from happening multiple times
                        
                        NoToken = true; // Prevent LoMuts tokens from appearing on the reroll
                        creator = LevCont;
        				num     = other.num;
        				alarm0	= num + 1;
        				skill   = "change_reroll";
        				name    = skill_get_name(skill);
        				text    = skill_get_text(skill);
                        mod_script_call("skill", skill, "skill_button");
                    }
                }


                instance_delete(self);
                with(LevCont) maxselect = instance_number(mutbutton) - 1; // Failsafe
                _last = true;
            }
        }
    }
    
    instance_destroy();