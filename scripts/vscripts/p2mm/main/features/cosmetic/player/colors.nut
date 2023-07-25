function player_colors_player_spawn(PackedArgs) {
    if (PackedArgs.PlayerClass.EntIndex >= p2mm.main.options.player_colors.starting_player_index) {
        local selected_color = p2mm.main.options.player_colors.color_list[PackedArgs.PlayerClass.EntIndex - p2mm.main.options.player_colors.starting_player_index]
        PackedArgs.PlayerClass.PlayerColor.setHSV(selected_color.h, selected_color.s, selected_color.v)
    }
}
hooks.playerActivate.addCallback(player_colors_player_spawn)