round <- function(num, point = 0) {
    local pw = pow(10, point)
    if ((num % 1) < 0.5) {
        return floor(num * pw) / pw
    } else {
        return ceil(num * pw) / pw
    }
}

RoundVector <- function(vec, point = 0) {
    local newvec = Vector(0.0, 0.0, 0.0)
    if (IsVec3(vec)) {
        newvec.x = round(vec.x, point)
        newvec.y = round(vec.y, point)
        newvec.z = round(vec.z, point)
    } else {
        newvec.x = round(vec.x, point)
        newvec.y = round(vec.y, point)
    }
    return newvec
}

CompareVectors <- function(vec1, vec2) {
    if (vec1.x == vec2.x && vec1.y == vec2.y && vec1.z == vec2.z) return true;
    return false;
}

//! ANGLES !//
ConvertToFlatFullAngle <- function(straightang) {
    local fullang = straightang % 360.0
    if (fullang < 0) fullang = 360.0 + fullang
    return fullang
}

ConvertToFullAngle <- function(ang) {
    local type = typeof ang
    if (type == "Vector") {
        local newang = Vector(0.0, 0.0, 0.0)
        if (IsVec3(newang)) {
            newang.x = ConvertToFlatFullAngle(ang.x)
            newang.y = ConvertToFlatFullAngle(ang.y)
            newang.z = ConvertToFlatFullAngle(ang.z)
        } else {
            newang.x = ConvertToFlatFullAngle(ang.x)
            newang.y = ConvertToFlatFullAngle(ang.y)
            newang.y = ang.y
        }
        return newang
    } else {
        return ConvertToFlatFullAngle(ang)
    }
}

ConvertToFlatLimitedAngle <- function(ang) {
    local limitedang = ang % 360
    if (limitedang > 180) {
        limitedang = limitedang - 360
    } else if (limitedang < -180) {
        limitedang = limitedang + 360
    }
    return limitedang
}

ConvertToLimitedAngle <- function(ang) {
    local type = typeof ang
    if (type == "Vector") {
        local newang = Vector(0.0, 0.0, 0.0)
        if (IsVec3(newang)) {
            newang.x = ConvertToFlatLimitedAngle(ang.x)
            newang.y = ConvertToFlatLimitedAngle(ang.y)
            newang.z = ConvertToFlatLimitedAngle(ang.z)
        } else {
            newang.x = ConvertToFlatLimitedAngle(ang.x)
            newang.y = ConvertToFlatLimitedAngle(ang.y)
            newang.y = ang.y
        }
        return newang
    } else {
        return ConvertToFlatFullAngle(ang)
    }
}

AddFlatFullAngles <- function(ang1, ang2) {
    return (ang1 + ang2) % 360
}

AddFlatLimitedAngles <- function(ang1, ang2) {
    return ConvertToFlatLimitedAngle(AddFlatFullAngles(ConvertToFlatFullAngle(ang1), ConvertToFlatFullAngle(ang2)))
}

AddAngles <- function(ang1, ang2) {
    local type = typeof ang1
    if (type == "Vector") {
        if (IsVec3(ang1)) {
            return Vector(AddFlatLimitedAngles(ang1.x, ang2.x), AddFlatLimitedAngles(ang1.y, ang2.y), AddFlatLimitedAngles(ang1.z, ang2.z))
        } else {
            return Vector(AddFlatLimitedAngles(ang1.x, ang2.x), AddFlatLimitedAngles(ang1.y, ang2.y), ang1.z)
        }
    } else {
        return AddFlatLimitedAngles(ang1, ang2)
    }
}
//!--------!//