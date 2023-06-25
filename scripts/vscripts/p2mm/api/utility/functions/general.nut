// used for getting the keys from a table
keys <- function(table) {
    local returnkeys = []
    foreach (key, val in table) {
        returnkeys.append(key)
    }
    return returnkeys
}

// used for getting the values from a table
values <- function(table) {
    local returnvals = []
    foreach (key, val in table) {
        returnvals.append(val)
    }
    return returnvals
}

// ::printlraw <- ::printl
// ::printl <- ::printl