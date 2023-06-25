// mapspawn.nut is called twice on map transitions for some reason...
// Prevent the second run

if (!("Entities" in this)) { return }

printl("calling p2mm===")

IncludeScript("p2mm/api/api.nut")

function cp() {
    hotglue.toolkit.entity.LinkedPortalDoor(Transform(Vector(6160, 3775, 263 + 128), Vector(0,180,0), Vector(128, 128)), Transform(Vector(3776, 3584, -383), Vector(0,0,0), Vector(128, 128))).openDoor(2)
    hotglue.toolkit.entity.LinkedPortalDoor(Transform(Vector(4180, 3599, -511), Vector(-90,0,180), Vector(128, 128)), Transform(Vector(5441, 3743, -561), Vector(0,0,0), Vector(128, 128))).openDoor()
}

function myPostMapSpawn(PackedArgs) {
    cp()
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