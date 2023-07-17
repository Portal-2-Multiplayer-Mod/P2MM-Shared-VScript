// mapspawn.nut is called twice on map transitions for some reason...
// Prevent the second run

if (!("Entities" in this)) { return }

printl("calling p2mm===")

IncludeScript("p2mm/api/api.nut")
IncludeScript("p2mm/main/main.nut")

//! TEST CODE PLEASE IGNORE !//
// function cp() {
//     hotglue.toolkit.entity.LinkedPortalDoor(Transform(Vector(6132.5, 3775, 263 + 128), Vector(0,180,0), Vector(128, 128)), Transform(Vector(3776, 3584, -383), Vector(0,0,0), Vector(128, 128))).openDoor(2)
//     hotglue.toolkit.entity.LinkedPortalDoor(Transform(Vector(4280, 3585.432617, -508), Vector(-90,0,180), Vector(128, 128)), Transform(Vector(5250, 3743, -720), Vector(0,0,0), Vector(128, 128))).openDoor()
// }

function cp() {
    ::fb <- Entities.CreateByClassname("prop_floor_button")
    // SetLocation(fb, Transform(Vector(5101.981934, 3581.680664, -447.968750)))
    ActivateEntity(fb)
    InitializeEntity(fb)

    hotglue.toolkit.entity.CustomButton(Transform(Vector(0,0,0)))
}

function myPostMapSpawn(PackedArgs) {
    if (InString(game.ServerInfo.mapName, "hub") || InString(game.ServerInfo.mapName, "lobby")) {
        cp()
    }
}
hooks.postMapSpawn.addCallback(myPostMapSpawn);

// Varible Types
// Var <- false;                   //* bVar
// Var <- 0;                       //* iVar
// Var <- 0.0;                     //* fVar\

// Var <- "";                      //* szVar
// Var <- [];                      //* aVar
// Var <- {};                      //* tVar

// Var <- func();                  // if it returns a bool, start with "Has" or "Is"
// Var <- class {};                //* CVar
// Var <- Entities.First();        //* pVar
// Var <- Vector;                  //* vecLocation