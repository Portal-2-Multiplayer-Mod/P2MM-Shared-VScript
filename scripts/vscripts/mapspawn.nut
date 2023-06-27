// mapspawn.nut is called twice on map transitions for some reason...
// Prevent the second run

if (!("Entities" in this)) { return }

printl("calling p2mm===")

IncludeScript("p2mm/api/api.nut")

function cp() {
    hotglue.toolkit.entity.LinkedPortalDoor(Transform(Vector(6132.5, 3775, 263 + 128), Vector(0,180,0), Vector(128, 128)), Transform(Vector(3776, 3584, -383), Vector(0,0,0), Vector(128, 128))).openDoor(2)
    hotglue.toolkit.entity.LinkedPortalDoor(Transform(Vector(4280, 3585.432617, -508), Vector(-90,0,180), Vector(128, 128)), Transform(Vector(5250, 3743, -720), Vector(0,0,0), Vector(128, 128))).openDoor()
    // SetLocation(Entities.FindByName(null, "platform_target"), Transform(Vector(6463.017090, 3765.085449, 500)))
}

function myPostMapSpawn(PackedArgs) {
    cp()
    if (!InString(ServerInfo.mapName, "lobby_3")) return
    ::btn <- Entities.CreateByClassname("prop_button")
    SetKeyValue(btn, "delay", "2.0")
    SetKeyValue(btn, "istimer", true)
    SetLocation(btn, Transform(Vector(5099.564941, 3744.429199, -447)))
    InitializeEntity(btn)

    ::btn2 <- Entities.CreateByClassname("prop_floor_button")
    SetLocation(btn2, Transform(Vector(5099.564941, 3744.429199, -200)))
    InitializeEntity(btn2)


    // ::trigger <- Entities.CreateByClassname("trigger_multiple");
    // trigger.__KeyValueFromString("targetname", "hello");
    // trigger.SetOrigin(Vector(4949.352051, 3734.940674, -447));
    // trigger.SetAngles(0,0,0);
    // trigger.SetSize(Vector(-100,-100,-100), Vector(100,100,100));
    // trigger.__KeyValueFromInt("spawnflags", 1);
    // trigger.__KeyValueFromInt("Solid", 3);
    // trigger.__KeyValueFromInt("CollisionGroup", 3);
    // EntFireByHandle(trigger, "AddOutput", "OnStartTouch !self:kill::0:-1")
    // EntFireByHandle(trigger, "Enable")
    // InitializeEntity(trigger)

    ::testing <- Entities.CreateByClassname("func_brush")
    // testing.__KeyValueFromInt(KEY_VALUES.COMMON.solid_i, SOLIDS.OBB)
    SetKeyValue(testing, KEY_VALUES.COMMON.model_sz, GetEntListByName("robo_rampa_01_panel")[0].GetModelName())
    // testing.__KeyValueFromInt(KEY_VALUES.COMMON.spawnflags_i, 1)
    // testing.__KeyValueFromInt(KEY_VALUES.COMMON.movetype_i, MOVETYPE.PUSH)
    // testing.__KeyValueFromInt(KEY_VALUES.COMMON.collisiongroup_i, COLLISION_GROUP.INTERACTIVE_DEBRIS)
    // testing.SetSize(Vector(-100,-100,-100), Vector(100,100,100))
    // testing.__KeyValueFromVector(KEY_VALUES.COMMON.mins_vec, Vector(-100,-100,-100))
    // testing.__KeyValueFromVector(KEY_VALUES.COMMON.maxs_vec, Vector(100,100,100))
    SetLocation(testing, Transform(Vector(4453.431641, 3584.789551, -437.044037), Vector(0,0,0)))
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