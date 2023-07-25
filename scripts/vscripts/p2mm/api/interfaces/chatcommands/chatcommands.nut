IncludeScript("p2mm/api/interfaces/chatcommands/classes/ChatCommand.nut")

chat <- {
    commands = []
}

chat.addChatCommand <- function(activation_word, func, adminlevel=0, help=null) {
    chat.commands.append(ChatCommand(activation_word, func, adminlevel, help))
}

function chat_commands_chat_message(PackedArgs) {
    local message = PackedArgs.Message
    if (!Startswith(Strip(message), "!")) return
    local playerclass = PackedArgs.PlayerClass
    local segmented_message = QuotesList(split(message, " "))
    local args = Index(segmented_message, "1:")
    foreach (command in chat.commands) {
        if (Replace(segmented_message[0], "!", "") != command.Activator) continue
        if (playerclass.AdminLevel >= command.AdminLevel) {
            command.runCommand(args, playerclass)
        }
    }
}
hooks.rawChatMessage.addCallback(chat_commands_chat_message)