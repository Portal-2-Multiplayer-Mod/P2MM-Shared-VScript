// used for getting the Keys from a table
Keys <- function(table) {
    local returnkeys = []
    foreach (key, val in table) {
        returnkeys.append(key)
    }
    return returnkeys
}

// used for getting the Values from a table
Values <- function(table) {
    local returnvals = []
    foreach (key, val in table) {
        returnvals.append(val)
    }
    return returnvals
}

InString <- function(string, search) {
    return string.find(search) != null
}

SetConvar <- function(convarname, val) {
    local valtype = typeof val
    if (valtype == "string") {
        SetConVarString(convarname, val);
        return true;
    } 
    if (valtype == "integer") {
        SetConVarInt(convarname, val);
        return true;
    }
    // if (valtype == "bool") {
    //     SetConvarInt(convarname, )
    // }
    return false;
}