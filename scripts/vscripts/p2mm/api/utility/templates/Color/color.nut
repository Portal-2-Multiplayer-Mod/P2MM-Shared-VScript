function rgb_to_hsv(r, g, b) {
    r = r.tofloat() / 255.0
    g = g.tofloat() / 255.0
    b = b.tofloat() / 255.0
    local minval = min([r, g, b]).tofloat()
    local maxval = max([r, g, b]).tofloat()

    local h = 0.0
    local s = 0.0
    local v = 0.0

    local delta = maxval - minval

    // H 360
    if (minval == maxval) h = 0
    else if (maxval == r) h = (60 * ((g - b) / delta) + 360) % 360
    else if (maxval == g) h = (60 * ((b - r) / delta) + 120) % 360
    else if (maxval == b) h = (60 * ((r - g) / delta) + 240) % 360

    // S 100
    if (maxval == 0) {
        s = 0
    } else {
        s = (delta / maxval) * 100
    }

    // V 100
    v = maxval * 100

    return {h=h / 360.0, s=s / 100.0, v=v / 100.0}
}

function hsv_to_rgb(ih, is, iv) {
    local h
    if (ih > 1) h = ih / 360.0
    else h = ih
    local s
    if (is > 1) s = is / 100.0
    else s = is
    local v
    if (iv > 1) v = iv / 100.0
    else v = iv

    if (s > 0) {
        if (h == 1.0) h = 0.0
        local i = (h * 6.0).tointeger()
        local f = h * 6.0 - i

        local w = v * (1.0 - s)
        local q = v * (1.0 - s * f)
        local t = v * (1.0 - s * (1.0 - f))

        local valset = []
        printl(i)
        switch (i) {
            case 0: valset = [v, t, w]; break;
            case 1: valset = [q, v, w]; break;
            case 2: valset = [w, v, t]; break;
            case 3: valset = [w, q, v]; break;
            case 4: valset = [t, w, v]; break;
            case 5: valset = [v, w, q]; break;
        }

        return {r=round(valset[0] * 255), g=round(valset[1] * 255), b=round(valset[2] * 255)}
    } else {
        return {r=v * 255, g=v * 255, b=v * 255}
    }
}

function combine_hsv(h1,s1,v1,h2,s2,v2) {
    local h = AddFlatFullAngles(h1 * 360.0, h2 * 360.0) / 360.0
    local s = (s1 + s2) / 2
    local v = (v1 + v2) / 2
    return {h=h, s=s, v=v}
}

IncludeScript("p2mm/api/utility/templates/Color/classes/Color.nut")