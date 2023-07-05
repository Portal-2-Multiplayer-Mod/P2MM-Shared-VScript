templateKeys.modelkeys <- class {
    Model = "models/error.mdl"
    Scale = 1.0
    Skin = 0
    BodyGroup = null; // TODO: FINISH THIS
    LinkedEnts = null;

    apply = function(ent) {
        // if (!IsInArray(precachedmodels, model)) // we dont do this cause it is slower then just running precache regardless
        Model = RepairModelName(Model)
        PrecacheModel(Model)
        SetKeyValue(ent, "model", Model)
        ent.SetModel(Model)

        SetKeyValue(ent, "modelscale", Scale)
        SetKeyValue(ent, "skin", Skin)
    }

    addLinkedEnt = function(ent, doapply = false) {
        LinkedEnts.append(ent);
        if (doapply) apply(ent);
    }

    applyLinkedEnts = function() {
        foreach (linkedent in LinkedEnts) {
            apply(ent);
        }
    }

    constructor() {
        LinkedEnts = [];
    }
}