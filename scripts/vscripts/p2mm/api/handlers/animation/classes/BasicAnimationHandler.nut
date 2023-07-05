//TODO: impliment looping
class BasicAnimationHandler {
    Entity = null;

    LoopAnim = false;
    CurrentAnimation = null;

    CurrentSequence = null;
    CurrentSequenceStep = -1;

    DefaultAnim = "idle";

    OnAnimationStart  = GenericHook("OnAnimationStart");
    OnAnimationFinish = GenericHook("OnAnimationFinish");

    force_on_animation_start = function() {
        if (CurrentAnimation == null) return
        this.OnAnimationStart.callCallbacks({
            Animation = CurrentAnimation
        })
    }

    force_on_animation_finish = function() {
        if (CurrentAnimation == null) return
        this.OnAnimationFinish.callCallbacks({
            Animation = CurrentAnimation
        })
        if (CurrentSequenceStep != -1) {
            stepSequence()
        } else {
            CurrentAnimation = null;
        }
    }

    stepSequence = function() {
        CurrentSequenceStep += 1
        if (CurrentSequenceStep <= (CurrentSequence.len() - 1)) {
            local steptype = typeof CurrentSequence[CurrentSequenceStep]
            if (steptype == "string") {
                runAnimation(CurrentSequence[CurrentSequenceStep])
            } else if (steptype == "integer") {
                local delay = CurrentSequence[CurrentSequenceStep]
                CurrentSequenceStep += 1
                if (CurrentSequenceStep <= (CurrentSequence.len() - 1)) {
                    runAnimation(CurrentSequence[CurrentSequenceStep], delay)
                } else {
                    CurrentSequenceStep = -1
                    return
                }
            }
        } else {
            CurrentSequenceStep = -1
            return
        }
    }

    runAnimation = function(animname, delay = 0, setcurrent = true) {
        if (setcurrent) CurrentAnimation = animname
        EntFireByHandle(Entity, "SetAnimation", animname, delay)
    }

    runAnimationSequence = function(seq) {
        this.CurrentSequence = seq;
        CurrentSequenceStep = -1;
        stepSequence()
    }

    applySettings = function() {
        SetKeyValue(Entity, "HoldAnimation", !LoopAnim)
    }

    constructor(entity, defaultanim = "idle", initapply = true) {
        Entity = entity;
        DefaultAnim = defaultanim;

        AddScriptOutput(entity, "OnAnimationBegun", force_on_animation_start, {Scope=this, Name="force_on_animation_start"})
        AddScriptOutput(entity, "OnAnimationDone", force_on_animation_finish, {Scope=this, Name="force_on_animation_finish"})

        if (initapply) applySettings()
    }
}