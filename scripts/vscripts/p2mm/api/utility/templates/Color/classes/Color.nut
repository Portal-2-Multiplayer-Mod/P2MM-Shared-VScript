::Color <- class {
    r = 255
    g = 255
    b = 255

    h = 1.0 // maps to 0-360
    s = 1.0 // maps to 0-100
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

    mixColor = function(clr, repopulate = true) {
        local mixedhsv = mix_hsv(h,s,v,clr.h,clr.s,clr.v)
        if (repopulate) setHSV(mixedhsv.h, mixedhsv.s, mixedhsv.v)
        return mixedhsv
    }

    constructor(r=255,g=255,b=255) {
        onChangeHook = GenericHook("OnColorChange")
        setRGB(r, g, b)
    }
}