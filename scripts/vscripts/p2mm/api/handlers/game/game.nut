ServerInfo <- {
    mapName=null
    isCoop=null
    isWorkshop=null
    knownGame=true
    GameTypes=[]
}

sharedents <- {
    point_clientcommand = null,
    point_servercommand = null,
    game_text = null
}

IncludeScript("p2mm/api/handlers/game/bugfixes/bugfixes.nut")

//-----------------------
//setup
//-----------------------

function game_handler_post_map_spawn(PackedArgs) {
    ServerInfo.mapName = GetMapName()
    ServerInfo.isCoop = InString(ServerInfo.mapName, "mp_coop")
    ServerInfo.isWorkshop = InString(ServerInfo.mapName, "workshop/")

    local GameDir = GetGameDirectory();
    switch (GameDir) {
        case "portal2":         
            ServerInfo.GameTypes.append("base");
            break;
        case "portal2_sixense": 
            ServerInfo.GameTypes.append("sixense");
            ServerInfo.GameTypes.append("base");
            break;
        case "aperturetag":
            ServerInfo.GameTypes.append("tag");
            break;
        case "portal_stories":
            ServerInfo.GameTypes.append("mel");
            break;
        case "portalreloaded":
            ServerInfo.GameTypes.append("reloaded");
            break;
        default: 
            ServerInfo.knownGame = false; 
            ServerInfo.GameTypes.append(GameDir)
            break;
    }

    sharedents.game_text <- Entities.CreateByClassname("game_text")
    sharedents.point_clientcommand <- Entities.CreateByClassname("point_clientcommand")
    sharedents.point_servercommand <- Entities.CreateByClassname("point_servercommand")
    SetName(sharedents.point_servercommand, "p2mm_servercommand")

    AddBranchLevelName( 1, "P2 MM" )
}
hooks.postMapSpawn.addCallback(game_handler_post_map_spawn, "GameHandler", 10)