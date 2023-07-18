SetConvar <- function(convarname, val, force=false) {
    local valtype = typeof val
    if (valtype == "string") {
        if (force) SetConVarString(convarname, val);
        else SendToConsole(convarname + " " + val);
        return true;
    }
    if (valtype == "integer") {
        if (force) SetConVarInt(convarname, val);
        else SendToConsole(convarname + " " + val.tostring());
        return true;
    }
    if (valtype == "bool") {
        if (val) {
            if (force) SetConVarInt(convarname, 1);
            else SendToConsole(convarname + " 1");
        } else {
            if (force) SetConVarInt(convarname, 0);
            else SendToConsole(convarname + " 0");
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