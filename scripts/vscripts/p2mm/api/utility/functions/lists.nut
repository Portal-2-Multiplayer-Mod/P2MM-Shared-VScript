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

Index <- function(table, indx) {
    if (typeof indx == "integer"){
        if (indx < -0) {
            return table[table.len() - indx]
        } else {
            return table[indx]
        }
    } else {
        local lst = split(indx, ":")
        local start = lst[0].tointeger()
        local end
        if (lst.len() > 1) end = lst[1].tointeger()
        else end = -1
        local newlist = []
        if (start < -0) end = table.len() - start
        if (end < -0) end = table.len() - end
        foreach (cindx, element in table) {
            if (cindx >= start && cindx <= end) newlist.append(element)
        }
        return newlist
    }
}

Join <- function(table, char = " ") {
    if (table.len() < 1) return ""
    local str = ""
    foreach (element in table) {
        str += element.tostring() + char
    }
    str = str.slice(0,str.len() - 1)
    return str
}