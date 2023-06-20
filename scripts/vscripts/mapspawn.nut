// mapspawn.nut is called twice on map transitions for some reason...
// Prevent the second run

if (!("Entities" in this)) { return }

printl("calling p2mm===")

IncludeScript("p2mm/api/api.nut")


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