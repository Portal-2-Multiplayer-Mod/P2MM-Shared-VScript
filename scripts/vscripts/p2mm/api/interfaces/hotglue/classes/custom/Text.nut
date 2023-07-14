hotlgue.storage.TextCharHashMap = {
    s128="models/props_bts/rail_horizontal_straight_128.mdl",
    s64="models/props_bts/rail_horizontal_straight_64.mdl",
    s32="models/props_bts/rail_horizontal_straight_32.mdl",
    c32="models/props_bts/rail_horizontal_corner_32.mdl",
    c16="models/props_bts/rail_horizontal_corner_16.mdl"
}
local tc = hotlgue.storage.TextCharHashMap
hotglue.storage.TextChars = {}
hotglue.storage.TextChars["A"] = [
    [Transform(Vector(8,20,64), Vector(-15, 270, 90),null,1), tc.s128]
    [Transform(Vector(8,52,64), Vector(-15, 90, 90),null,1), tc.s128]
    [Transform(Vector(8,36,44), Vector(-90 180 0),null,1), tc.s64]
]

//TODO: add start enabled and letter color
//TODO: add letter move
hotglue.toolkit.custom.Letter <- class {
    AssociatedPropPackets = [];

    constructor(char, transform) {
        local letterlist = hotglue.storage.TextChars[char]
        foreach (part in letterlist) {
            local CharPropPacket = {
                Offset = part[0],
                Prop = hotglue.toolkit.entity.PropDynamic(part[1], part[0])
            }
            AssociatedProps.append(CharPropPacket)
        }
    }
}

hotglue.toolkit.custom.Text <- class {
    LetterSpacing = 64

    genLetter = function(char) {
        
    }
    
    constructor(message, origin, scale = 1) {
        LetterSpacing = LetterSpacing * scale
    }
}