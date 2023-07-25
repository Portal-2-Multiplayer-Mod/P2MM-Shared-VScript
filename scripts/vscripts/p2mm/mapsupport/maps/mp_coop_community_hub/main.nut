printl("Loading coop hub support")

function myPostMapSpawn(PackedArgs) {
    // hotglue.toolkit.entity.VGuiMovieDisplay("media/insert_disk.bik", Transform(Vector(4480, 4587, -129), Vector(0, 0, 90), Vector(510, 1279)))
    // ::musicEnt <- hotglue.toolkit.entity.AmbientGeneric(Transform(Vector(5132, 4544, -33)), "music/ctc_b1_006.wav", {StartSilent=false, Everywhere=true})
    ::pair1 <- hotglue.toolkit.entity.LinkedPortalDoor(Transform(Vector(-384, 0, 256), Vector(0,0,0), Vector(384, 255)), Transform(Vector(384,0,256), Vector(0,180,0), Vector(384, 255)));
    ::pair2 <- hotglue.toolkit.entity.LinkedPortalDoor(Transform(Vector(0, -384, 256), Vector(0,90,0), Vector(384, 255)), Transform(Vector(0,384,256), Vector(0,-90,0), Vector(384, 255)));

    pair1.openDoor(0, true)
    // pair2.openDoor(0, true)
}
hooks.postMapSpawn.addCallback(myPostMapSpawn);