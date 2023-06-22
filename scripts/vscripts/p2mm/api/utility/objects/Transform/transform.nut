::RawVector <- ::Vector
::Vector <- function(x, y, z = null) {
    local vec2 = false
    if (z == null) {
        z = 3280.3280;
        vec2 = true
    }
    local vec = RawVector(x, y, z);
    return vec
}

isVec2 <- function(vec) {
    return (vec.z == 3280.3280)
}

isVec3 <- function(vec) {
    return (vec.z != 3280.3280)
}

UnpackVector <- function(vec) {
    return vec.x, vec.y, vec.z;
}

IncludeScript("p2mm/api/utility/objects/Transform/classes/Transform.nut")