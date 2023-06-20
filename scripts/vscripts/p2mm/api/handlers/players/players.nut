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

function player_handler_player_connect(PackedArgs) {
    playerclasses[PackedArgs.EntIndex] <- CPlayerClass(PackedArgs.EntIndex, PackedArgs.Username, PackedArgs.SteamID, PackedArgs.IPAddress, PackedArgs.IsBot)
}
hooks.playerConnect.addCallback(player_handler_player_connect)

function player_handler_player_activate(PackedArgs) {
    ValidatePlayerClass(PackedArgs.EntIndex)
    FindPlayerClassByEntIndex(PackedArgs.EntIndex).finalize()
}
hooks.playerActivate.addCallback(player_handler_player_activate)

function player_handler_player_death(PackedArgs) {
    if (!ValidatePlayerClass(PackedArgs.PlayerClass, PackedArgs.EntIndex)) PackedArgs.PlayerClass = FindPlayerClassByEntIndex(PackedArgs.EntIndex)
    PackedArgs.PlayerClass.Alive = false
    PackedArgs.PlayerClass.Deaths += 1
}
hooks.playerDeath.addCallback(player_handler_player_death)

function player_handler_player_spawn(PackedArgs) {
    if (!ValidatePlayerClass(PackedArgs.PlayerClass, PackedArgs.EntIndex)) PackedArgs.PlayerClass = FindPlayerClassByEntIndex(PackedArgs.EntIndex)
    PackedArgs.PlayerClass.Alive = true
}
hooks.playerSpawn.addCallback(player_handler_player_spawn)