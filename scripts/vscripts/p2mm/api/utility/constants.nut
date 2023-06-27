::SOLIDS <- {
    NONE			= 0,	// no solid model
    BSP			    = 1,	// a BSP tree
    BBOX			= 2,	// an Axis Aligned Bounding Box aka cannot rotate
    OBB			    = 3,	// an Oriented Bounding Box aka can rotate
    OBB_YAW		    = 4,	// an OBB, constrained so that it can only yaw
    CUSTOM	        = 5,	// Aks the entitys c++ code what to use every call
    VPHYSICS	    = 6,	// solid vphysics object, get vcollide from the model and collide with that
}

::COLLISION_GROUP <- {
    NONE                = 0,
    DEBRIS			    = 1,    // Collides with nothing but world and static stuff
    DEBRIS_TRIGGER      = 2,    // Same as debris, but hits triggers. Useful for an item that can be shot, but doesn't collide.
    INTERACTIVE_DEBRIS	= 3,    // Collides with everything except other interactive debris or debris
    INTERACTIVE	        = 4,    // Collides with everything except interactive debris or debris
    PLAYER              = 5,    // Collides with players?
    BREAKABLE_GLASS     = 6,    // NPCs can see straight through an Entity with this applied.
    VEHICLE             = 7,
    PLAYER_MOVEMENT     = 8,    // For HL2, same as Collision_Group_Player, for TF2, this filters out other players and CBaseObjects

    NPC			        = 9,    // Generic NPC group
    IN_VEHICLE		    = 10,   // Doesn't collide with anything, no traces
    WEAPON			    = 11,   // Doesn't collide with players and vehicles
    VEHICLE_CLIP	    = 12,   // Only collides with vehicles
    PROJECTILE		    = 13,   // Is a projectile collides with stuff that projectiles collide with
    DOOR_BLOCKER	    = 14,   // Blocks entities not permitted to get near moving doors
    PASSABLE_DOOR	    = 15,   // Lets the Player through, nothing else.
    DISSOLVING		    = 16,   // Things that are dissolving are in this group
    PUSHAWAY		    = 17,   // Nonsolid on client and server, pushaway in player code

    NPC_ACTOR		    = 18,   // Used so NPCs in scripts ignore the player.
    NPC_SCRIPTED	    = 19,   // USed for NPCs in scripts that should not collide with each other
    PZ_CLIP             = 20,   //? Doesn't collide with players/props

    // PORTAL 2 ONLY
        CAMERA_SOLID		= 22,   // Solid only to the camera's test trace
        PLACEMENT_SOLID     = 23,   // Solid only to the placement tool's test trace
        PLAYER_HELD		    = 24,   // Held objects that shouldn't collide with players
        WEIGHTED_CUBE		= 25,   // Cubes need a collision group that acts roughly like COLLISION_GROUP_NONE but doesn't collide with debris or interactive
    // END OF PORTAL 2 ONLY

    DEBRIS_BLOCK_PROJECTILE = 26,   // Only collides with bullets

    LAST_SHARED_COLLISION_GROUP = 27
}

MOVETYPE <- {
    NONE		= 0,	// never moves
    ISOMETRIC	= 1,	// For players -- in TF2 commander view, etc.
    WALK		= 2,	// Player only - moving on the ground
    STEP		= 3,	// gravity, special edge handling -- monsters use this
    FLY		    = 4,	// No gravity, but still collides with stuff
    FLYGRAVITY	= 5,	// flies through the air + is affected by gravity
    VPHYSICS	= 6,	// uses VPHYSICS for simulation
    PUSH		= 7,	// no clip to world, push and crush
    NOCLIP		= 8,	// No gravity, no collisions, still do velocity/avelocity
    LADDER		= 9,	// Used by players only when going onto a ladder
    OBSERVER	= 10,	// Observer movement, depends on player's observer mode
    CUSTOM		= 11	// Allows the entity to describe its own physics
}

::RENDER_FX <- {
    NORMAL           = 0,
    PULSE1           = 1,
    PULSE2           = 2,
    PULSE3           = 3,
    PULSE4           = 4,
    PULSE5           = 17,
    STROBE1          = 9,
    STROBE2          = 10,
    STROBE3          = 11,
    SLOW_FLICKER     = 12,
    FAST_FLICKER     = 13,
    FADE_OUT_LONG    = 5,
    FADE_OUT_SHORT   = 6,
    FADE_IN_LONG     = 7,
    FADE_IN_SHORT    = 8,
    FADE_OUT_INSTANT = 15,
    FADE_IN_INSTANT  = 16,
    CONSTANT_GLOW    = 14,
    GLOW_SHELL       = 18
}

::RENDER_MODES <- {
    NORMAL                      = 0,
    COLOR                       = 1,
    TEXTURE                     = 2,
    GLOW                        = 3,
    SOLID                       = 4,
    ADDITIVE                    = 5,
    ADDITIVE_FRACTIONAL_FRAME   = 6,
    WORLD_SPACE_GLOW            = 9,
    DONT_RENDER                 = 10
}


::KEY_VALUES <- {
    COMMON = {
        rendercolor_sz             =  "rendercolor",            // Takes "255 255 255 255" "RED GREEN BLUE ALPHA"
        renderamt_i                =  "renderamt",              // Takes 0-255 essentially an alpha //! rendermode must be set to color
        rendermode_i               =  "rendermode"              // Takes one of our helper RENDERMODEs and
        disableshadows_b           =  "disableshadows",         // Takes bool self explanitory 
        drawinfastreflection_b     =  "drawinfastreflection",   // Takes bool will draw in the default reflections
        disableshadowdepth_b       =  "disableshadowdepth",     // Takes bool this makes the prop not effect env_projected_texture
        shadowdepthnocache_i       =  "shadowdepthnocache"      // Takes int (0 does nothing 1 adds the effect 2 removes the effect) if the effect is on then it will only render the objects shadow once in the env_projected_texture meaning if you move it the shadow stays in the same place
        mins_vec                   =  "mins",                   // Takes vector sets min part of bounding box //! BETTER THEN .SetSize PROBABLY
        maxs_vec                   =  "maxs",                   // Takes vector sets max part of bounding box //! BETTER THEN .SetSize PROBABLY
        disablereciveshadows_b     =  "disablereceiveshadows",  // Takes bool stops itself from reciving shadows //TODO: Test what this is for we know its not env_projected tho
        disableflashlight_b        =  "disableflashlight",      // Takes bool stops itself from reciving light from env_projected_textures
        nodamageforces_b           =  "nodamageforces",         // Takes bool disables damage pushback/velocity
        angle_i                    =  "angle",                  // Takes int sets pitch only
        angles_vec                 =  "angles",                 // Takes vector sets pitch yaw and roll
        origin_vec                 =  "origin",                 // Takes vector sets origin/position of entity
        targetname_sz              =  "targetname",             // Takes string sets targetname/name of the entity in the world
        mincpulevel_i              =  "mincpulevel",            // Takes int (0:"default (low)",1:"low", 2:"medium",3:"high") still unsure what this means but its the minimum val pretty sure its software rendering graphics levels see below for gpu mode
        maxcpulevel_i              =  "maxcpulevel",            // Takes int (0:"default (high)",1:"low", 2:"medium",3:"high") still unsure what this means but its the maximum val pretty sure its software rendering graphics levels see below for gpu mode
        mingpulevel_i              =  "mingpulevel",            // Takes int (0:"default (very low)",1:"very low",2:"low",3:"medium","high") minimum value your graphics must be on to see this object
        mingpulevel_i              =  "maxgpulevel",            // Takes int (0:"default (high)",1:"very low",2:"low",3:"medium","high") maximum value your graphics can be on to see this object
        startdisabled_b            =  "startdisabled",          // Takes bool should entity start disabled
        skin_i                     =  "skin",                   // Takes int that corrisponds to the desired skin or the model
        skinset_sz                 =  "skinset",                // Takes string that contains all desired skin numbers seperated by a space eg "4 2 6" all skins outside of the ones specified will not be useable if left blank all skins will be useable aka default
        solid_i                    =  "solid",                  // Takes int sets the solid types from our declarations above
        model_sz                   =  "model",                  // Takes string sets model of entity
        movetype_i                 =  "movetype",               // Takes int sets movetype of entity
        spawnflags_i               =  "spawnflags",             // Takes int that is simular to a byte that contains out flags
        collisiongroup_i           =  "collisiongroup"          // Takes int that our helper nums above provide to set what it collides with
    }
}
