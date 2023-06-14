class Callback {
    Name = "UnnamedCallback"
    CallbackFunction = null;
    PostCallbacks = []

    constructor(callback_function, name = null) {
        if (name != null) Name = name
        CallbackFunction = callback_function
    }

    addPostCallback = function(callback) {
        PostCallbacks.push(callback)
    }

    runCallback = function(argsArray) {
        CallbackFunction(argsArray)
        foreach (callback in PostCallbacks) {
            callback.runCallback(argsArray)
        }
    }
}

class GenericHook {
    callbacks = {}; // this is specifically for top-level not nested callbacks
    allcallbacks = {}; // this is for storing all callbacks, nested or not
    heldcallbacks = {}; // this is for callbacks that are trying to hook callbacks that havent been created yet. We store them here until the function name is created

    generateCallback = function(inputFunction, replace = false, name = null) {
        if (name == null) {
            local infos = inputFunction.getinfos()
            if ("name" in keys(infos)) name = infos.name
        }
        if (name == null) assert("Name must be provided!") // Assert if we have no name
        if (!replace && (name in keys(allcallbacks))) assert("Callback tried to overwrite value with replace set to false!")

        // finally assign the callback if everything is in order
        local callback = Callback(inputFunction, name)

        return callback
    }

    addCallback = function(inputFunction, replace = false, name = null) {
        local callback = generateCallback(inputFunction, replace, name)

        if (callback.Name in keys(heldcallbacks)) {
            callback.addPostCallback(heldcallbacks[callback.Name]) // add any waiting callbacks to the new callback
            delete heldcallbacks[callback.Name]
        }

        callbacks[callback.Name] <- callback
        allcallbacks[callback.Name] <- callback
    }

    addHookCallback = function(inputFunction, nameOfCallbackToHook, replace = false, name = null) {
        local callback = generateCallback(inputFunction, replace, name)

        if (callbackName in allcallbacks) {
            allcallbacks[nameOfCallbackToHook].addPostCallback(callback)
            allcallbacks[callback.Name] <- callback
        } else {
            heldcallbacks[nameOfCallbackToHook] <- callback // put it in holding until the name of the callback is created
        }
    }

    callCallbacks = function(arrayFormArgs = []) {
        foreach (callback in callbacks) {
            callback.runCallback(arrayFormArgs);
        }
    }

    constructor() {
        // nothing atm..
    }
}