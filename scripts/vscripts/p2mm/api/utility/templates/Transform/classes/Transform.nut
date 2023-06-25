Transform <- class {
    Origin = null;
    Angles = null;
    Size   = null;

    constructor(origin = null, angles = null, size = null) {
        if (origin != null && IsVec3(origin))               Origin = origin; // vec3
        if (angles != null && IsVec3(angles))               Angles = angles; // vec3
        if (size   != null && IsVec3(size) || IsVec2(size)) Size   =   size; // vec3 or vec2
    }
}

Transform2D <- class {
    Origin = null;
    Angles = null;
    Size   = null;

    constructor(origin = null, angles = null, size = null) {
        if (origin != null && IsVec2(origin))               Origin = origin; // vec2
        if (angles != null && IsVec2(angles))               Angles = angles; // vec2
        if (size   != null && IsVec2(size))                 Size   =   size; // vec2
    }
}