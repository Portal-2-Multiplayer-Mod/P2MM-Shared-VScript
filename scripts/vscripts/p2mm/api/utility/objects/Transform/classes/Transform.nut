Transform <- class {
    Origin = null;
    Angles = null;
    Size   = null;

    constructor(origin = null, angles = null, size = null) {
        if (origin != null && isVec3(origin))               Origin = origin; // vec3
        if (angles != null && isVec3(angles))               Angles = angles; // vec3
        if (size   != null && isVec3(size) || isVec2(size)) Size   =   size; // vec3 or vec2
    }
}

Transform2D <- class {
    Origin = null;
    Angles = null;
    Size   = null;

    constructor(origin = null, angles = null, size = null) {
        if (origin != null && isVec2(origin))               Origin = origin; // vec2
        if (angles != null && isVec2(angles))               Angles = angles; // vec2
        if (size   != null && isVec2(size))                 Size   =   size; // vec2
    }
}