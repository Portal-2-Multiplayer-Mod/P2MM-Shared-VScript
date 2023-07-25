hotglue.toolkit.entity.VGuiMovieDisplay <- class {
    Entity = null;
    Stretch = null;
    Looping = null;
    Enabled = null;
    Filename = null;
    TForm = null;

    setMovie = function(filename=null, enabled = null) {
        if (enabled != null) Enabled = enabled
        if (filename != null) Filename = RepairMediaName(filename)
        if (Entity != null) {
            this.TForm = Transform(Entity.GetOrigin(), GetRealAngles(Entity), TForm.Size)
            Entity.Destroy()
        }
        Entity = Entities.CreateByClassname("vgui_movie_display")
        SetLocation(Entity, TForm)
        SetKeyValue(Entity, "moviefilename", Filename)
        SetKeyValue(Entity, "height", TForm.Size.x)
        SetKeyValue(Entity, "width", TForm.Size.y)
        SetKeyValue(Entity, "looping", Looping)
        SetKeyValue(Entity, "stretch", Stretch)
        InitializeEntity(Entity)
        if (Enabled) EntFireByHandle(Entity, "enable", "", 0.1)
    }

    // TODO: ENABLE/DISABLE
    constructor(filename, transform, stretch=true, looping=true, enabled=true) {
        Stretch = stretch
        Looping = looping
        Enabled = enabled
        Filename = RepairMediaName(filename)
        this.TForm = transform
        setMovie()
    }
}