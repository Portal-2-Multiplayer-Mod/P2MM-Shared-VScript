InString <- function(string, search) {
    return string.find(search) != null
}

Startswith <- function(string, search) {
    if (string.len() < search.len()) return false;
    local string = string.slice(0, search.len())
    if (string == search) return true;
    return false;
}

Endswith <- function(string, search) {
    if (string.len() < search.len()) return false;
    local string = string.slice(string.len() - search.len(), string.len())
    if (string == search) return true;
    return false;
}

LStrip <- function(str, chars = " ") {
    local startIndex = 0
    local len = str.len()

    while (startIndex < len && chars.find(str.slice(startIndex, startIndex + 1)) != null) {
        startIndex++
    }

    return str.slice(startIndex)
}

RStrip <- function(str, chars = " ") {
    local endIndex = str.len() - 1

    while (endIndex >= 0 && chars.find(str.slice(endIndex, endIndex + 1)) != null) {
        endIndex--
    }

    return str.slice(0, endIndex + 1)
}

Strip <- function(str) {
    return RStrip(LStrip(str))
}

StringIndex <- function(str, indx, lefttoright = true) {
    if (lefttoright) return str.slice(indx, indx + 1)
    else return str.slice((str.len() - 1) - indx, ((str.len() - 1) - indx) + 1)
}

Replace <- function(str, search, replace) {
    local str = str
    local find = str.find(search)
    while (find != null) {
        str = str.slice(0, find) + replace + str.slice(find + (search.len()))
        find = str.find(search)
    }
    return str
}

Count <- function(str, count) {
    local str = str
    local find = str.find(count)
    local total = 0
    while (find != null) {
        total++
        str = str.slice(0, find) + str.slice(find + (count.len()))
        find = str.find(count)
    }
    return total
}

//TODO: Rework this to actually act correctly
QuotesList <- function(args) {
    local newargs = []
    local inQuotes = false
    foreach (arg in args) {
        if (InString(arg, "\"")) {
            local parts = split(arg, "\"")
            foreach (part in parts) {
                if (part != "") {
                    if (inQuotes) {
                        newargs[newargs.len() - 1] += " " + part
                    } else {
                        newargs.append(part)
                    }
                    inQuotes = !inQuotes
                }
            }
        } else if (inQuotes) {
            newargs[newargs.len() - 1] += " " + arg
        } else {
            newargs.append(arg)
        }
    }
    return newargs
}
