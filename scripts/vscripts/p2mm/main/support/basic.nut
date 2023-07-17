function basic_support_player_spawn_hook(PackedArgs) {
    if (p2mm.main.options.player_avoidance.enable
        && p2mm.main.options.player_avoidance.min_players >= game.CurrentPlayers) {
            SetConvar("portal_use_player_avoidance", true)
    } else {
        SetConvar("portal_use_player_avoidance", false)
    }
};
hooks.playerSpawn.addCallback(basic_support_player_spawn_hook);
