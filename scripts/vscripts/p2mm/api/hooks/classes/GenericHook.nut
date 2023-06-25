//TODO: Add importance levels

class Callback {
    HeldFunction = null;
    Name = "null";
    attachedCallbacks = null;

    run = function(PackedArgs) {
        HeldFunction(PackedArgs)
        foreach (callback in attachedCallbacks) callback.run(PackedArgs)
    }

    attachCallback = function(callback) {
        attachedCallbacks.append(callback)
    }

    constructor(inputFunction, name = null) {
        this.attachedCallbacks = []
        HeldFunction = inputFunction
        if (name == null) Name = inputFunction.getinfos().name
        else Name = name
    }
}

class GenericHook {
    CallbackList = null;
    AllCallbacks = null;
    HeldCallbacks = null;
    Name = "UnnamedCallback";

    constructor(name = null) {
        if (typeof name  == "string") Name = name;
        this.CallbackList = [] // Very odd thing with lists in classes, if we dont it will combine all the lists between all instances..
        this.AllCallbacks = []
        this.HeldCallbacks = {} // name:callback
    }

    genCallback = function(inputFunction, name = null) {
        local newCallback = Callback(inputFunction, name)
        return newCallback
    }

    addCallback = function(inputFunction, name = null) {
        local callback = genCallback(inputFunction, name)
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

        if (!(callbackName in keys(HeldCallbacks))) HeldCallbacks[callbackName] <- []
        HeldCallbacks[callbackName].append(newcallback)
        AllCallbacks.append(newcallback)
    }

    callCallbacks = function(PackedArgs) {
        foreach (curcallback in CallbackList) {
            curcallback.run(PackedArgs)
        }
    }
}