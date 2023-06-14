IncludeScript("modules/api/hooks/classes/GenericHook.nut")

hooks <- {} // = is ref <- is assign

hooks.playerInit <- GenericHook();
function player_activate(eindx) {
    hooks.playerInit.callCallbacks([eindx]);
}

hooks.chatMessage <- GenericHook();
function ChatCommands(eindx, msg) {
    hooks.chatMessage.callCallbacks([eindx, msg]);
}

hooks.postMapLoad <- GenericHook();
function postMapLoad(argsArray) {
    local eindx = argsArray[0]
    if (eindx == 1) hook.postMapLoad.callCallbacks()
}
hooks.playerInit.addCallback(postMapLoad)