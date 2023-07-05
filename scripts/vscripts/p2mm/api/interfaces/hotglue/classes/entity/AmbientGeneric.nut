hotglue.toolkit.entity.AmbientGeneric <- class {
    Entity = null;
    Sound = null;
    
    setFlags = function(flagstable) {
        local flags = 0
        if ("Everywhere" in flagstable && flagstable["Everywhere"] == true) flags += 1
        if ("StartSilent" in flagstable && flagstable["StartSilent"] == true) flags += 16
        if ("NotLooped" in flagstable && flagstable["NotLooped"] == true) flags += 32

        SetKeyValue(Entity, "spawnflags", flags)
    }

    setSound = function(soundname) {
        Entity.PrecacheSoundScript(soundname)
        SetKeyValue(Entity, "message", soundname)
        this.Sound = soundname
    }

    playSound = function(soundname = null) {
        if (soundname == null) soundname = Sound
        Entity.PrecacheSoundScript(soundname)
        // EntFireByHandle(Entity, "playsound")
        Entity.EmitSound(soundname)
    }

    constructor(transform, soundname = "", flagstable = {}, volume=10, radius=1250, pitch=100, keyvals = {}) {
        Entity = Entities.CreateByClassname("ambient_generic");
        if (!(soundname == "")) {
            Entity.PrecacheSoundScript(soundname)
            SetKeyValue(Entity, "message", soundname)
            Sound = soundname
        }
        SetKeyValue(Entity, "health", volume)
        SetKeyValue(Entity, "radius", radius)
        SetKeyValue(Entity, "pitch", pitch)
        SetKeyValue(Entity, "pitchstart", pitch)

        SetLocation(Entity, transform)
        setFlags(flagstable)
        SetKeyValuesFromTable(Entity, keyvals)
        InitializeEntity(Entity)
    }
}