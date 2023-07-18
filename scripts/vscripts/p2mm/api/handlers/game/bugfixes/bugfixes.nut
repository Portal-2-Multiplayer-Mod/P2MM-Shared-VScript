function bugfixes_player_activate(PackedArgs) {
    local clientcommands = [
        "r_portal_fastpath 0",
        "r_portal_use_pvs_optimization 0",
        "mat_motion_blur_forward_enabled 0",
        "stopvideos",
    ]

    local servercommands = {
        ["mp_wait_for_other_player_notconnecting_timeout"] = 0,
        ["mp_wait_for_other_player_timeout"] = 0,
        ["sv_timeout"] = 3
    }

    foreach (command in clientcommands) {
        PackedArgs.PlayerClass.sendCommand(command)
    }

    foreach (command, val in servercommands) {
        SetConvar(command, val, true)
    }
}
hooks.playerActivate.addCallback(bugfixes_player_activate)