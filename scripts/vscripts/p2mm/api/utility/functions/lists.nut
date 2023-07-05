FindInArray <- function(arr, searchobj) {
    foreach (indx, obj in arr) {
        if (obj == searchobj) return indx
    }
    return null
}

IsInArray <- function(arr, searchobj) {
    return (FindInArray(arr, searchobj) != null)
}

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

ValueToKey <- function(table, value) {
    foreach (key, val in table) if (val == value) return key
    return null;
}