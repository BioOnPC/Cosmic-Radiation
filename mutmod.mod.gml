#define init
    global.obj_list = [
        "GreasedAura"
    ];


#define obj_create(_x, _y, _name)
	if(is_real(_name) && object_exists(_name)){
		instance_create(_x, _y, _name);
	}
	else if(is_string(_name)){
		var _scrt = _name + "_create";
		
		if(mod_script_exists(mod_current_type, mod_current, _scrt)){
			return mod_script_call(mod_current_type, mod_current, _scrt, _x, _y);
		}
	}
	
	return global.obj_list;

#define GreasedAura_create(_x, _y)
    with(instance_create(_x, _y, CustomObject)) {
        name	= "GreasedAura";
        
        size	= 64;
        timer	= 120;
        
        on_step = script_ref_create(GreasedAura_step);
        on_draw = script_ref_create(GreasedAura_draw);
        
        return self;
    }
    
#define GreasedAura_step    
	timer -= current_time_scale;
	
	with(Player) {
		if(place_meeting(x, y, other)) {
			if(reload > 0) reload -= 0.4;
			if(breload > 0) breload -= 0.4;
		}
	}
	
	if(timer <= 0) {
		instance_destroy();
	}

#define GreasedAura_draw
    draw_circle_color(x, y, size + random(4), c_navy, c_navy, 0);
    