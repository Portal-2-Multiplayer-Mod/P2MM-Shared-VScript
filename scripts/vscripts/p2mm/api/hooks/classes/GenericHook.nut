class Callback {
    HeldFunction = null;
    Name = "null";

    run = function(PackedArgs) {
        HeldFunction(PackedArgs)
    }

    constructor(inputFunction) {
        HeldFunction = inputFunction
        Name = inputFunction.getinfos().name
    }
}

class GenericHook {
    CallbackList = null;
    Name = "UnnamedCallback";

    constructor(name = null) {
        if (typeof name  == "string") Name = name;
        this.CallbackList = [] // Very odd thing with lists in classes, if we dont it will combine all the lists between all instances..
    }

    genCallback = function(inputFunction) {
        local newCallback = Callback(inputFunction)
        return newCallback
    }

    addCallback = function(inputFunction) {
        local callback = genCallback(inputFunction)
        CallbackList.append(callback)
    }

    callCallbacks = function(PackedArgs) {
        foreach (curcallback in CallbackList) {
            curcallback.run(PackedArgs)
        }
    }
}