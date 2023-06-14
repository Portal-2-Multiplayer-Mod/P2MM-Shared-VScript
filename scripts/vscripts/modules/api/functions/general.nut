// used for getting the keys from a table
keys <- function(table) {
    local returnkeys = []
    foreach (key in table) {
        returnkeys.append(key)
    }
    return returnkeys
}

// used for getting the values from a table
values <- function(table) {
    local returnvals = []
    foreach (key in table) {
        returnvals.append(table[key])
    }
    return returnkeys
}