LoopInstances <- []
function generic_loop_main_loop(PackedArgs) {
    local curfps = 1/FrameTime()
    foreach (genericloop in LoopInstances) {
        genericloop.CurrentItterations += 1
        local neededItters = curfps * (1.0 / genericloop.CallsPerSecond) 
        if (genericloop.CurrentItterations >= neededItters) {
            genericloop.RunFunctions()
            genericloop.CurrentItterations = 0
        }
    }
}
hooks.mainLoop.addCallback(generic_loop_main_loop)

class GenericLoop {
    CallsPerSecond = 1
    CurrentItterations = 0
    FunctionsToBeCalled = null

    StartLoop = function() {
        if (IsInArray(LoopInstances, this)) return;
        LoopInstances.append(this)
    }

    PauseLoop = function() {
        local instIndx = FindInArray(LoopInstances, this)
        if (instIndx == null) return;
        LoopInstances.remove(instIndx)
    }

    AddFunction = function(func) {
        FunctionsToBeCalled.append(func)
    }

    RunFunctions = function() {
        foreach (func in FunctionsToBeCalled) func()
    }

    constructor(callspersec, startInstantly = false, firstRunImmediate = false) {
        this.FunctionsToBeCalled = []
        CallsPerSecond = callspersec
        if (firstRunImmediate) CurrentItterations = ceil(1/FrameTime())
        if (startInstantly) StartLoop()
    }
}