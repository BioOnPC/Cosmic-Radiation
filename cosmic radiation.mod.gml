#define init
	//this is set to true when lib is done loading, check this before using lib in step events and such
	global.libLoaded = false;
	if(fork()){
		//wait for lib to be loaded, first of all.
		while(!mod_exists("mod", "lib")){wait(1);}

		//This tells lib to check this mod for hooks and to give the global variable (in this case global.scr) the list of functions lib can use
		script_ref_call(["mod", "lib", "getRef"], mod_current_type, mod_current, "scr");
		
		//This is where you put what modules you want to load.
		var modules = [/*"libImprovements"*/];
		with(modules) {
			call(scr.import, self);
			while(!mod_exists("mod", self)){wait(1);}
		}
		
		while(!mod_exists("mod", "libGeneral")){wait(1);}
		
		//Lib is done loading, set the global variable.
		global.libLoaded = true;
		exit;
	}

	while(!global.libLoaded) wait 0;
	
	//Continue the rest of your init here
	call(scr.obj_setup, mod_current, ["Fake"]);
	
	
//These are macros to slot in to make it easier to call lib functions.
#macro scr global.scr
#macro call script_ref_call
#macro mod_current_type script_ref_create(0)[0]

#define step
	if(!global.libLoaded){ exit; }

#define Fake_create(_x, _y)
	with(instance_create(_x, _y, CustomHitme)) {
		 // Sprites:
		spr_idle	= sprTargetIdle;
		spr_walk	= sprTargetIdle;
		spr_hurt	= sprTargetHurt;
		spr_dead	= sprTargetDead;
		spr_shadow	= shd24;
		
		image_speed = 0;
		
		 // Sounds:
		snd_hurt = sndHitPlant;
		snd_dead = sndWallBreakJungle;
		
		maxhealth = 1;
		my_health = maxhealth;
		
		size        = 1;
		right       = choose(1, -1);
		
		return self;
	}

#define Fake_step
	if(my_health <= 0 or (instance_exists(Player) and distance_to_object(instance_nearest(x, y, Player)) < 64)) {
		instance_destroy();
		exit;
	}
	
	speed = 0;
	x = xprevious;
	y = yprevious;
	
#define Fake_hurt(_dmg, _spd, _dir)
	if(!instance_exists(Player) or distance_to_object(instance_nearest(x, y, Player)) < 128) {
	    my_health -= _dmg;
	    nexthurt = current_frame + 5;
	    sprite_index = spr_hurt;
	    image_index = 0;
	    sound_play_hit(snd_hurt, 0.6);
	}

#define Fake_destroy
	repeat(size) {
		with(instance_create(x + call(scr.orandom, 6), y + call(scr.orandom, 6), Ally)) {
			if(instance_exists(Player)) creator = instance_nearest(x, y, Player);
		}
	}
	
	with(instance_create(x, y, Corpse)) {
		size = other.size;
		sprite_index = other.spr_dead;
		image_xscale = other.right;
		speed = min((other.speed + max(0, -other.my_health / 5)) * (8 * skill_get(mut_impact_wrists)), 16);
		direction = other.direction;
	}
	
	sound_play_pitch(snd_dead, 1.2 + random(0.2));
	
	repeat(irandom_range(3, 6)) {
		with(instance_create(x, y, Feather)) {
			sprite_index = sprTutorialSplinter;
		}
	}
	
	