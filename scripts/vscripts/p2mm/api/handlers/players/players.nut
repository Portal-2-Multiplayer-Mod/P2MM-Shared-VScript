IncludeScript("p2mm/api/handlers/players/classes/PlayerClass.nut")

playerclasses <- {};

function ValidatePlayerClass(input, eindx = null) {
    if (input == null && eindx != null) { // we can assume that we were gived the output of a FindPlayerClass function and it didn't exist therefor create
        playerclasses[eindx] <- CPlayerClass(eindx, GetPlayerName(eindx), GetSteamID(eindx), null, false);
        return false;
    }
    
    if (typeof input == "integer" && FindPlayerClassByEntIndex(input) == null) {
        playerclasses[input] <- CPlayerClass(input, GetPlayerName(input), GetSteamID(input), null, false); // wont be a bot cause a bot would have ran connect
        return false;
    }

    return true;
}

//-----------
// hooks
//-----------

function player_handler_player_connect(PackedArgs) {
    playerclasses[PackedArgs.EntIndex] <- CPlayerClass(PackedArgs.EntIndex, PackedArgs.Username, PackedArgs.SteamID, PackedArgs.IPAddress, PackedArgs.IsBot)
}
hooks.playerConnectRaw.addCallback(player_handler_player_connect, "CreatePlayerClass")

function player_handler_player_activate(PackedArgs) {
    ValidatePlayerClass(PackedArgs.EntIndex)
    FindPlayerClassByEntIndex(PackedArgs.EntIndex).finalize()
}
hooks.playerActivateRaw.addCallback(player_handler_player_activate, "CreatePlayerClass")

function player_handler_player_spawn(PackedArgs) {
    ValidatePlayerClass(PackedArgs.EntIndex)
    local playerclass = FindPlayerClassByEntIndex(PackedArgs.EntIndex)
    if (playerclass.Alive == false) {
        playerclass.Alive = true;
        post_player_class_player_spawn(PackedArgs); // player spawn is called many times so we decide when the player actually spawns and call the main hook
    }
}
hooks.playerSpawnRaw.addCallback(player_handler_player_spawn, "CreatePlayerClass")

function player_handler_player_death(PackedArgs) {
    ValidatePlayerClass(PackedArgs.EntIndex)
    local playerclass = FindPlayerClassByEntIndex(PackedArgs.EntIndex)
    playerclass.Alive = false
    playerclass.Deaths += 1
}
hooks.playerDeathRaw.addCallback(player_handler_player_death, "CreatePlayerClass")

function player_handler_player_disconnect(PackedArgs) {
    if (PackedArgs.PlayerClass != null) {
        PackedArgs.PlayerClass.disconnect()
    }
}
hooks.playerDisconnect.addCallback(player_handler_player_disconnect, "CreatePlayerClass", -3)