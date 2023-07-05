/*
PURPOSE:

Define engine hooks and custom p2mm hooks.
TODO: We gotta make these function names harder to replace
TODO: Make player disconnect use priority levels specifically playerclass removal needs to run last
*/

IncludeScript("p2mm/api/hooks/classes/GenericHook.nut")

hooks <- {};

hooks.playerConnectRaw <- GenericHook("playerConnect");
function player_connect(eindx, name, steamid, ipaddr, bot) {
    hooks.playerConnectRaw.callCallbacks({
        EntIndex = eindx,
        Username = name,
        SteamID = steamid,
        IPAddress = ipaddr,
        IsBot = bot
    })
}

hooks.playerActivateRaw <- GenericHook("playerActivateRaw");
function player_activate(eindx) {
    hooks.playerActivateRaw.callCallbacks({
        EntIndex = eindx
    })
}

hooks.playerSpawnRaw <- GenericHook("playerSpawnRaw");
function player_spawn(eindx, teamnum) {
    hooks.playerSpawnRaw.callCallbacks({
        EntIndex = eindx
    })
}

hooks.playerDeathRaw <- GenericHook("playerDeathRaw");
function player_death(eindx, attacker, weapon) {
    hooks.playerDeathRaw.callCallbacks({
        Attacker = attacker,
        Weapon = weapon,
        EntIndex = eindx
    });
}

hooks.playerDisconnect <- GenericHook("playerDisconnect")
function player_disconnect(eindx, reason, name, networkid) {
    hooks.playerDisconnect.callCallbacks({
        PlayerClass = FindPlayerClassByEntIndex(eindx),
        Reason = reason
    })
}

hooks.mainLoop <- GenericHook("mainLoop")
function HandleGameFrame(simulating) {
    hooks.mainLoop.callCallbacks({
        Simulating = simulating
    })
}
IncludeScript("p2mm/api/hooks/classes/GenericLoop.nut")


//-----------------------------
// VScript Corrected Callbacks
//-----------------------------

hooks.playerConnect <- GenericHook("playerConnect");
function post_player_class_player_connect(PackedArgs) {
    hooks.playerConnect.callCallbacks({
        PlayerClass = FindPlayerClassByEntIndex(PackedArgs.EntIndex)
    })
}
hooks.playerConnectRaw.attachCallbackToCallback(post_player_class_player_connect, "CreatePlayerClass")

hooks.playerActivate <- GenericHook("playerActivate");
function post_player_class_player_activate(PackedArgs) {
    hooks.playerActivate.callCallbacks({
        PlayerClass = FindPlayerClassByEntIndex(PackedArgs.EntIndex)
    })
}
hooks.playerActivateRaw.attachCallbackToCallback(post_player_class_player_activate, "CreatePlayerClass")

hooks.playerSpawn <- GenericHook("playerSpawn");
function post_player_class_player_spawn(PackedArgs) {
    hooks.playerSpawn.callCallbacks({
        PlayerClass = FindPlayerClassByEntIndex(PackedArgs.EntIndex)
    })
}
// Spawn is called numerous times so we have the playerclass handler determine when someone actually spawns

hooks.playerDeath <- GenericHook("playerDeath");
function post_player_class_player_death(PackedArgs) {
    hooks.playerDeath.callCallbacks({
        Attacker = PackedArgs.Attacker,
        Weapon = PackedArgs.Weapon,
        PlayerClass = FindPlayerClassByEntIndex(PackedArgs.EntIndex)
    })
}
hooks.playerDeathRaw.attachCallbackToCallback(post_player_class_player_death, "CreatePlayerClass")

//------------------
// custom callbacks
//------------------

::hasRanPostMapSpawn <- false
hooks.postMapSpawn <- GenericHook("postMapSpawn");
function p2mm_post_map_spawn(PackedArgs) {
    if (::hasRanPostMapSpawn == false) {
        hooks.postMapSpawn.callCallbacks({})
        ::hasRanPostMapSpawn = true
    }
}
hooks.playerSpawn.addCallback(p2mm_post_map_spawn)