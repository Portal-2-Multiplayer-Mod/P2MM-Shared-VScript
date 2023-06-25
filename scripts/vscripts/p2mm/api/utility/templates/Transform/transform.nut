::RawVector <- ::Vector
::Vector <- function(x, y, z = null) {
    local vec2 = false
    if (z == null) {
        z = 32803280.3280;
        vec2 = true
    }
    local vec = RawVector(x, y, z);
    return vec
}

IsVec2 <- function(vec) {
    return (vec.z == 32803280.3280)
}

IsVec3 <- function(vec) {
    return (vec.z != 32803280.3280)
}

UnpackVector <- function(vec) {
    return vec.x, vec.y, vec.z;
}

IncludeScript("p2mm/api/utility/templates/Transform/classes/Transform.nut")