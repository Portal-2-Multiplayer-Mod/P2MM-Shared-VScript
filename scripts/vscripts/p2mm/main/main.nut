::p2mm.main <- {
    enable = true

    options = {
        player_avoidance = {
            enable = true
            min_players = 3
        }

        player_colors = {
            enable = true
            starting_player_index = 2
            color_list = [
                // Regular Colors
                Color(120, 50, 80, false)
                Color(60, 50, 80, false)
                Color(20, 65, 80, false)
                Color(0, 65, 80, false)
                Color(320, 50, 80, false)
                Color(260, 60, 80, false)
                Color(220, 60, 80, false)
                Color(180, 60, 80, false)
                // Neon Colors
                Color(120, 100, 100, false)
                Color(60, 100, 100, false)
                Color(20, 100, 100, false)
                Color(0, 100, 100, false)
                Color(320, 100, 100, false)
                Color(260, 100, 100, false)
                Color(220, 100, 100, false)
                Color(180, 100, 100, false)
                // Desaturated Colors
                Color(120, 30, 80, false)
                Color(60, 30, 80, false)
                Color(20, 30, 80, false)
                Color(0, 30, 80, false)
                Color(320, 30, 80, false)
                Color(260, 30, 80, false)
                Color(220, 30, 80, false)
                Color(180, 30, 80, false)
                // Deep Colors
                Color(120, 100, 40, false)
                Color(60, 100, 40, false)
                Color(20, 100, 40, false)
                Color(0, 72, 40, false)
                Color(320, 100, 40, false)
                Color(260, 100, 40, false)
                Color(220, 100, 40, false)
                Color(180, 100, 40, false)
            ]
        }
    }
};

IncludeScript("p2mm/main/support/basic.nut")
IncludeScript("p2mm/main/features/features.nut")