::game <- {
    ServerInfo = {
        mapName=null
        isCoop=null
        isWorkshop=null
        knownGame=true
        GameTypes=[]
    }

    MapSupport = {
        hasMapSupport=false
        developerModeMapSupport=true

        mapSpecificOptions={}
    }

    SharedEnts = {
        point_clientcommand = null,
        point_servercommand = null,
        game_text = null
    }

    CurrentPlayers = 0
}

IncludeScript("p2mm/api/handlers/game/bugfixes/bugfixes.nut")

//-----------------------
//setup
//-----------------------
game.ServerInfo.mapName = GetMapName()
game.ServerInfo.isCoop = InString(game.ServerInfo.mapName, "mp_coop")
game.ServerInfo.isWorkshop = InString(game.ServerInfo.mapName, "workshop/")

function game_handler_post_map_spawn(PackedArgs) {
    local GameDir = GetGameDirectory();
    switch (GameDir) {
        case "portal2":
            game.ServerInfo.GameTypes.append("base");
            break;
        case "portal2_sixense":
            game.ServerInfo.GameTypes.append("sixense");
            game.ServerInfo.GameTypes.append("base");
            break;
        case "aperturetag":
            game.ServerInfo.GameTypes.append("tag");
            break;
        case "portal_stories":
            game.ServerInfo.GameTypes.append("mel");
            break;
        case "portalreloaded":
            game.ServerInfo.GameTypes.append("reloaded");
            break;
        default:
            game.ServerInfo.knownGame = false;
            game.ServerInfo.GameTypes.append(GameDir)
            break;
    }

    game.SharedEnts.game_text <- Entities.CreateByClassname("game_text")
    game.SharedEnts.point_clientcommand <- Entities.CreateByClassname("point_clientcommand")
    game.SharedEnts.point_servercommand <- Entities.CreateByClassname("point_servercommand")
    SetName(game.SharedEnts.point_servercommand, "p2mm_servercommand")

    AddBranchLevelName( 1, "P2 MM" )
}
hooks.postMapSpawn.addCallback(game_handler_post_map_spawn, "GameHandler", 10)

function game_handler_player_spawn_hook(PackedArgs) {
    game.CurrentPlayers += 1
};
hooks.playerSpawn.addCallback(game_handler_player_spawn_hook);

function game_handler_player_disconnect(PackedArgs) {
    game.CurrentPlayers -= 1
}
hooks.playerDisconnect.addCallback(game_handler_player_disconnect)
