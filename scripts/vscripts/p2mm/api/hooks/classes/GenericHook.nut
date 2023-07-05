function runInImportanceOrder(listofcallbacks, PackedArgs) {
    local runOrder = {}

    foreach (curcallback in listofcallbacks) {
        if (!(curcallback.importanceLevel in runOrder)) runOrder[curcallback.importanceLevel] <- []
        runOrder[curcallback.importanceLevel].append(curcallback)
    }

    local numOrder = Keys(runOrder)
    numOrder.sort()
    numOrder.reverse()
    foreach (num in numOrder) {
        foreach (curcallback in runOrder[num]) {
            curcallback.run(PackedArgs)
        }
    }
}

class Callback {
    HeldFunction = null;
    Name = null;
    attachedCallbacks = null;
    importanceLevel = 0;

    run = function(PackedArgs) {
        local ctype = typeof HeldFunction
        if (ctype == "table") {
            HeldFunction.Scope[HeldFunction.Name](PackedArgs)
        } else {
            HeldFunction(PackedArgs)
        }
        runInImportanceOrder(attachedCallbacks, PackedArgs)
    }

    attachCallback = function(callback) {
        attachedCallbacks.append(callback)
    }

    constructor(inputFunction, name = null, level = 0) {
        this.attachedCallbacks = []
        importanceLevel = level
        HeldFunction = inputFunction
        if (name == null)  {
            local ctype = typeof inputFunction
            if (ctype == "table") {
                Name = inputFunction.Name
            } else {
                Name = inputFunction.getinfos().name
            }
        } else {
            Name = name
        }
    }
}

class GenericHook {
    CallbackList = null;
    AllCallbacks = null;
    HeldCallbacks = null;
    Name = "UnnamedCallback";

    constructor(name = null) {
        if (typeof name  == "string") Name = name;
        this.CallbackList = [] // Very odd thing with lists in classes, if we dont set it in the constructor it will combine all the lists between all instances..
        this.AllCallbacks = []
        this.HeldCallbacks = {} // name:callback
    }

    genCallback = function(inputFunction, name = null, level = 0) {
        local newCallback = Callback(inputFunction, name, level)
        return newCallback
    }

    addCallback = function(inputFunction, name = null, level = 0) {
        local callback = genCallback(inputFunction, name, level)
        CallbackList.append(callback)
        AllCallbacks.append(callback)
        if (callback.Name in HeldCallbacks) {
            foreach (heldcallback in HeldCallbacks[callback.Name]) {
                callback.attachCallback(heldcallback)
            }
            delete HeldCallbacks[callback.Name]
        }
        return callback;
    }

    attachCallbackToCallback = function(inputFunction, callbackName, newCallbackName = null) {
        local newcallback = genCallback(inputFunction, newCallbackName)
        foreach (callback in AllCallbacks) {
            if (callback.Name == callbackName) {
                callback.attachCallback(newcallback)
                AllCallbacks.append(newcallback)
                return newcallback;
            }
        }

        if (!(callbackName in Keys(HeldCallbacks))) HeldCallbacks[callbackName] <- []
        HeldCallbacks[callbackName].append(newcallback)
        AllCallbacks.append(newcallback)
    }

    callCallbacks = function(PackedArgs) {
        runInImportanceOrder(CallbackList, PackedArgs)
    }
}