hotglue.toolkit.entity.PropDynamic <- class {
    Entity = null;

    AnimationHandler = null;

    // TODO: ENABLE/DISABLE
    constructor(templatemodelkeys, transform, collision=SOLIDS.VPHYSICS, disabled=false) {
        Entity = Entities.CreateByClassname("prop_dynamic");
        templatemodelkeys.apply(Entity);
        SetKeyValue(Entity, KEY_VALUES.COMMON.solid_i, collision)
        SetLocation(Entity, transform);
        InitializeEntity(Entity);
        this.AnimationHandler = BasicAnimationHandler(Entity)
    }
}