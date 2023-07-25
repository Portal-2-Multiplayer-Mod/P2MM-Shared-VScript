::Color <- class {
    r = 255
    g = 255
    b = 255

    h = 0.0 // maps to 0-360
    s = 0.0 // maps to 0-100
    v = 1.0 // maps to 0-100

    onChangeHook = null;

    getStringRGB = function () {
        return r.tostring() + " " + g.tostring() + " " + b.tostring()
    }

    getStringHSV = function () {
        return h.tostring() + " " + s.tostring() + " " + v.tostring()
    }

    getVectorRGB = function() {
        return Vector(r, g, b)
    }

    getVectorHSV = function() {
        return Vector(h, s, v)
    }

    getHex = function() {
        return toHex(r) + toHex(g) + toHex(b)
    }

    setRGB = function(r, g, b) {
        this.r = r
        this.g = g
        this.b = b

        local hsv = rgb_to_hsv(r,g,b)

        this.h = hsv.h
        this.s = hsv.s
        this.v = hsv.v

        onChangeHook.callCallbacks({Color=this})
    }

    setHSV = function(h, s, v) {
        this.h = h
        this.s = s
        this.v = v

        local rgb = hsv_to_rgb(h,s,v)

        r = rgb.r
        g = rgb.g
        b = rgb.b

        onChangeHook.callCallbacks({Color=this})
    }

    setHex = function(hex) {
        local hex = Replace(hex, " ", "")
        local r = toDec(hex.slice(0,2))
        local g = toDec(hex.slice(2,4))
        local b = toDec(hex.slice(4,6))

        setRGB(r,g,b)
    }

    mixColor = function(clr, repopulate = true) {
        local mixedhsv = mix_hsv(h,s,v,clr.h,clr.s,clr.v)
        if (repopulate) setHSV(mixedhsv.h, mixedhsv.s, mixedhsv.v)
        return mixedhsv
    }

    constructor(r=255,g=255,b=255,isrgb=true) {
        onChangeHook = GenericHook("OnColorChange")
        if (isrgb) setRGB(r, g, b)
        else setHSV(r, g, b)
    }
}