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