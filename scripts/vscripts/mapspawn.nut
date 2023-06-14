// mapspawn.nut is called twice on map transitions for some reason...
// Prevent the second run

if (!("Entities" in this)) { return }

printl("calling p2mm===")

// IncludeScript("modules/setup.nut")
// IncludeScript("modules/loop.nut")
IncludeScript("modules/api/api.nut")