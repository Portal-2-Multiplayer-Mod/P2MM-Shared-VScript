printl("Loading coop hub support")

function myPostMapSpawn(PackedArgs) {
    RemoveEntsInList([
        // GetEntListByOrigin(Vector(3910, 3424, -158))
        GetEntListByName("@music_lobby_7")
        GetEntListByName("@music_lobby_6")
        GetEntListByName("@music_lobby_5")
        GetEntListByName("@music_lobby_4")
        GetEntListByName("@music_lobby_3")
        GetEntListByName("@music_lobby_2")
        GetEntListByName("@music_lobby_1")
    ])

    hotglue.toolkit.entity.VGuiMovieDisplay("media/insert_disk.bik", Transform(Vector(4480, 4587, -129), Vector(0, 0, 90), Vector(510, 1279)))
    // ::musicEnt <- hotglue.toolkit.entity.AmbientGeneric(Transform(Vector(5132, 4544, -33)), "music/ctc_b1_006.wav", {StartSilent=false, Everywhere=true})
    // ::pair1 <- hotglue.toolkit.entity.LinkedPortalDoor(Transform(Vector(5055, 3584, -447), Vector(0,0,0), Vector(512, 512)), Transform(Vector(5182, 3584, -447), Vector(0,180,0), Vector(512, 512)));
}
hooks.postMapSpawn.addCallback(myPostMapSpawn);