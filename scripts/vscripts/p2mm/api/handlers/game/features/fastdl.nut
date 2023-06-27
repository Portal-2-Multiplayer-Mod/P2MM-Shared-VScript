function game_handler_fastdl_post_map_spawn(PackedArgs) {
    SetConvar("sv_downloadurl", "https://github.com/Portal-2-Multiplayer-Mod/P2MM-FastDL/raw/main/portal2/")
    SetConvar("sv_allowdownload", 1)
    SetConvar("sv_allowupload", 1)
}
hooks.postMapSpawn.addCallback(game_handler_fastdl_post_map_spawn)
