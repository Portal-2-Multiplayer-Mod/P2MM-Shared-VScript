convarconfigcheckloop <- GenericLoop(1)

function config_post_map_spawn(PackedArgs) {
    convarconfigcheckloop.StartLoop()
}
hooks.postMapSpawn.addCallback(config_post_map_spawn)