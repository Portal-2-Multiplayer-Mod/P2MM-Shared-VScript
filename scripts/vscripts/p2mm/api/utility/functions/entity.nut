// Redefine the EntFires to be somewhat sane
::RawEntFireByHandle <- ::EntFireByHandle
EntFireByHandle <- function(target, action, value = "", delay = 0.0, activator = null, caller = null) {
    if (typeof value != "string") value = value.tostring()
    RawEntFireByHandle(target, action, value, delay, activator, caller)
}

EntFire <- function(target, action, value = "", delay = 0.0, activator = null, caller = null) {
    if (typeof value != "string") value = value.tostring()
    DoEntFire(target, action, value, delay, activator, caller)
}

GetEntListByClassname <- function(classname) {
    local list = []
    for(local ent;ent = Entities.FindByClassname(ent, classname);) {
        list.push(ent)
    }
    return list
}

GetEntListByName <- function(name) {
    local list = []
    for(local ent;ent = Entities.FindByName(ent, name);) {
        list.push(ent)
    }
    return list
}

RawAddOutput <- function(ent, eventname, actionentname, action, value = "", delay = 0, maxfiretimes = -1) {
    EntFireByHandle(ent, "AddOutput", eventname + " " + actionentname + ":" + action + ":" + value + ":" + delay.tostring() + ":" + maxfiretimes.tostring())
}

RunScriptRegister <- function(register) {
    if (register.Context == null) { register.Func(); return; }
    register.Context.Scope[register.Context.Name]()
}
HeldAddOuputScriptFunctions <- {}
AddScriptOutput <- function(ent, eventname, func, context = null, delay = 0) {
    local functionRegister = ValueToKey(HeldAddOuputScriptFunctions, func)
    if (functionRegister == null) {
        functionRegister = UniqueString()
    }
    HeldAddOuputScriptFunctions[functionRegister] <- {
        Func = func,
        Context  = context
    }
    RawAddOutput(ent, eventname, "p2mm_servercommand", "command", "script RunScriptRegister(HeldAddOuputScriptFunctions[\"" + functionRegister + "\"])", delay)
}

SetName <- function(ent, name) {
    SetKeyValue(ent, "targetname", name)
}

SetParent <- function(ent, par) {
    local hasname = true;
    if (par.GetName() == "") hasname = false;
    if (!hasname) {
        SetName(par, UniqueString())
    }
     EntFireByHandle(ent, "SetParent", par.GetName())
}

SetAngles <- function(ent, vec) {
    ent.SetAngles(vec.x, vec.y, vec.z)
}

SetPos <- function(ent, vec) {
    ent.SetOrigin(vec)
}

SetLocation <- function(ent, transform) {
    if (transform.Angles != null) SetAngles(ent, transform.Angles)
    if (transform.Origin != null) SetPos(ent, transform.Origin)
}

GetRealAngles <- function(ent, round = true) {
    local spl = split(GetViewAngles(ent), ";")
    local vec = Vector(spl[0].tofloat(), spl[1].tofloat(), spl[2].tofloat())
    if (round) vec = Vector(floor(vec.x * 100) / 100, floor(vec.y * 100) / 100, floor(vec.y * 100) / 100)
    return vec;
}

SetKeyValue <- function(ent, key, val) {
    local valtype = typeof val
    switch (valtype) {
        case "bool":
            if (val) {ent.__KeyValueFromInt(key, 1)}
            else {ent.__KeyValueFromInt(key, 0)} 
            break;
        case "integer": 
            ent.__KeyValueFromInt(key, val)
            break;
        case "float":
            ent.__KeyValueFromString(key, val.tostring())
            break;
        case "Vector":
            ent.__KeyValueFromVector(key, val)
            break;
        case "string":
            ent.__KeyValueFromString(key, val)
            break;
    }
}

SetKeyValuesFromTable <- function(ent, table) {
    foreach (key, val in table) {
        SetKeyValue(ent, key, val)
    }
}