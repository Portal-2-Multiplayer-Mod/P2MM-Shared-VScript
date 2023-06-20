/*
PURPOSE:

Define engine hooks and custom p2mm hooks.
TODO: We gotta make these function names harder to replace
*/

IncludeScript("p2mm/api/hooks/classes/GenericHook.nut")

hooks <- {};

hooks.playerConnect <- GenericHook("playerConnect");
function player_connect(eindx, name, steamid, ipaddr, bot) {
    hooks.playerConnect.callCallbacks({
        EntIndex = eindx,
        Username = name,
        SteamID = steamid,
        IPAddress = ipaddr,
        IsBot = bot
    })
}

hooks.playerActivate <- GenericHook("playerActivate");
function player_activate(eindx) {
    hooks.playerActivate.callCallbacks({
        EntIndex = eindx
    })
}

hooks.playerSpawn <- GenericHook("playerSpawn");
function player_spawn(eindx, teamnum) {
    local Cplayerclass = FindPlayerClassByEntIndex(eindx);
    hooks.playerSpawn.callCallbacks({
        PlayerClass = Cplayerclass
        EntIndex = eindx
    })
}

hooks.playerDeath <- GenericHook("playerDeaths");
function player_death(eindx, attacker, weapon) {
    local Cplayerclass = FindPlayerClassByEntIndex(eindx);
    hooks.playerDeath.callCallbacks({
        PlayerClass = Cplayerclass,
        Attacker = attacker,
        Weapon = weapon,
        EntIndex = eindx
    });
}