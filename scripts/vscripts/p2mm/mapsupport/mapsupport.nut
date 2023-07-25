try {
    printl("")
    printl("")
    printl("=== P2MM MAP SUPPORT ===")
    printl("Found map support file:")
    printl("'scripts/vscripts/p2mm/mapsupport/maps/" + game.ServerInfo.mapName + "/main.nut'")
    printl("Loading...")
    printl("")
    printl(">-- MAIN.NUT OUTPUT --<")
    IncludeScript("p2mm/mapsupport/maps/" + game.ServerInfo.mapName + "/main.nut" )
    game.MapSupport.hasMapSupport = true
    printl(">---------------------<")
    printl("")
    printl("Loaded!")
    printl("========================")
    printl("")
} catch (exception) {
    printl(">---------------------<")
    printl("")
    printl("Failed to load :[")
    printl("========================")
}