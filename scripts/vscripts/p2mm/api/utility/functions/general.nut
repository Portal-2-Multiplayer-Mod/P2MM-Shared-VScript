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
    if (valtype == "bool") {
        if (val) {
            SetConvarInt(convarname, 1)
        } else {
            SetConvarInt(convarname, 0)
        }
    }
    return false;
}

RepairModelName <- function(modelname) {
    if (!Startswith(modelname, "models/")) {
        modelname = "models/" + LStrip(modelname, "/")
    }
    return modelname
}