ChatCommand <- class {
    HelpText = null
    Activator = null
    CommandHook = null
    AdminLevel = 0

    runCommand = function(args, playerclass) {
        CommandHook.callCallbacks({
            Args = args,
            PlayerClass = playerclass
        })
    }

    constructor(activation_word, func, adminlevel, help=null) {
        if (help == null) this.HelpText = ["[this command has no help text]"]
        else this.HelpText = help
        Activator = activation_word
        AdminLevel = adminlevel
        this.CommandHook = GenericHook("CommandHook")
        CommandHook.addCallback(func)
    }
}