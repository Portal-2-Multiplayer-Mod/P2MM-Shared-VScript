function test_command(PackedArgs) {
    PackedArgs.PlayerClass.SendMessage(Join(PackedArgs.Args, ";\n"))
}
chat.addChatCommand("test", test_command)

function rcon_command(PackedArgs) {
    SendToConsole(Join(PackedArgs.Args))
}
chat.addChatCommand("rcon", rcon_command)