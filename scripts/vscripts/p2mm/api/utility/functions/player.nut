GetAllPlayerClasses <- function(ExcludedPlayerclasses = []) {
    local returnclasses = [];
    foreach (Cplayerclass in values(playerclasses)) {
        if (Cplayerclass in ExcludedPlayerclasses) continue;
        returnclasses.append(Cplayerclass);
    }
    return returnclasses;
}

FindPlayerByEntIndex <- function(searchEntIndex) {
    foreach (ent in GetEntListByClassname("player")) {
        if (ent.entindex() == searchEntIndex) return ent;
    }
    return null;
}

FindPlayerClassByEntIndex <- function(searchEntIndex) {
    foreach (Cplayerclass in GetAllPlayerClasses()) {
        if (Cplayerclass.EntIndex == searchEntIndex) return Cplayerclass;
    }
}