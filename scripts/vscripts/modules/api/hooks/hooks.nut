IncludeScript("modules/api/hooks/classes/GenericHook.nut")

hooks <- {}

// engine hooks //

hooks.playerConnectRaw <- GenericHook();
function player_connect(eindx, name, steamid, ipaddr, isbot) { // player_connect
    isbot = (isbot != 0) // convert the 1 or 0 to a boolean
    if (ipaddr == "none") ipaddr = null
    hooks.playerConnectRaw.callCallbacks([eindx, name, steamid, ipaddr, isbot]);
}

//! Create a regular playerConnect that returns a playerclass

hooks.playerDisconnect <- GenericHook();
function player_disconnect(eindx, reason, name, steamid) {
    //! replace eindx with playerclass once new playerclass system has been made
    //! and the reason ofc
    hooks.playerDisconnect.callCallbacks([eindx, reason, name, steamid])
}

hooks.playerInitRaw <- GenericHook();
function player_activate(eindx) { // player_activate
    hooks.playerInitRaw.callCallbacks([eindx]);
}

//! make playerInit that returns playerclass

hooks.playerDeath <- GenericHook();
function player_death(eindx, attacker, weapon) { // player_death
    //! replace eindx with playerclass once new playerclass system has been made
    hooks.playerDeath.callCallbacks([eindx, attacker, weapon]);
}

hooks.playerSpawn <- GenericHook();
function player_spawn(eindx, teamnum) {
    //! replace eindx with playerclass once new playerclass system has been made
    hooks.playerSpawn.callCallbacks([eindx])
}

hooks.playerMessage <- GenericHook();
function ChatCommands(eindx, msg) { // player_say
    //! replace eindx with playerclass once new playerclass system has been made
    hooks.playerMessage.callCallbacks([eindx, msg]);
}

hooks.playerChangeName <- GenericHook();
function player_changename(eindx, newname) {
    //! replace eindx with playerclass once new playerclass system has been made
    hooks.playerChangeName.callCallbacks([eindx, newname])
}

//* custom hooks *//

hasRanPostMapLoad <- false;
hooks.postMapLoad <- GenericHook();
function postMapLoad(argsArray) {
    if (!hasRanPostMapLoad) {
        hasRanPostMapLoad = true;
        hooks.postMapLoad.callCallbacks();
    }
}
hooks.playerInitRaw.addCallback(postMapLoad)

hooks.playerKicked <- GenericHook();
function player_kicked(arrayArgs) {
    //! code for player kicked
}
hooks.playerDisconnect.addCallback(player_kicked)