hotglue.toolkit.entity.CustomButton <- class {
    Ents = null;
    Modelkeys = null;
    AnimationSequence = null;
    Sound = null;

    onPressedHook = null;
    onResetHook = null;

    onPressedFunc = function() {
        Ents.Prop.AnimationHandler.runAnimationSequence(AnimationSequence);
        Sound.setSound("Portal.button_down")
        Sound.playSound()
        onPressedHook.callCallbacks({})
    }
    
    onResetFunc = function(PackedArgs) {
        if (PackedArgs.Animation != this.AnimationSequence[(this.AnimationSequence.len() - 1)]) return;
        Sound.setSound("Portal.button_up")
        Sound.playSound()
        onResetHook.callCallbacks({})
    }

    //TODO: Replace the manual func_button with a hotglue func_button class
    constructor(transform, time=1, modelkeys = null, animseq = null, sound = null) {
        this.onPressedHook = GenericHook("OnPressed")
        this.onResetHook = GenericHook("OnReset")

        // if (sound == null) sound = "buttons/button_synth_positive_01.wav"
        if (sound == null) sound = "Portal.button_down"
        
        Sound = hotglue.toolkit.entity.AmbientGeneric(transform, sound)

        if (modelkeys == null) {
            this.Modelkeys = templateKeys.modelkeys()
            this.Modelkeys.Model = "models/props/switch001.mdl"
        } else {
            this.Modelkeys = modelkeys
        }

        if (animseq == null) {
            this.AnimationSequence = [
                "down",
                time.tointeger(),
                "up"
            ];
        }

        this.Ents = {
            Prop = hotglue.toolkit.entity.PropDynamic(this.Modelkeys, transform),
            Func = Entities.CreateByClassname("func_button")
        }

        SetLocation(Ents.Func, transform)
        SetKeyValue(Ents.Func, "spawnflags", "1025")
        SetKeyValue(Ents.Func, "wait", time + 0.65)
        ActivateEntity(Ents.Func)
        InitializeEntity(Ents.Func)
        SetParent(Ents.Prop.Entity, Ents.Func)
        AddScriptOutput(Ents.Func, "OnPressed", onPressedFunc, {Scope=this, Name="onPressedFunc"})
        Ents.Prop.AnimationHandler.OnAnimationStart.addCallback({Scope=this, Name="onResetFunc"})
    }
}