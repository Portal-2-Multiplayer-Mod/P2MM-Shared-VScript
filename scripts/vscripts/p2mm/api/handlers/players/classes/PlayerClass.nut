/* 
TODO: Add importance levels
*/

class CPlayerClass {
    // Class Handling
    FullyInitalized = false;

    // Essential
    PlayerEntity = null;
    EntIndex = -1;
    SteamID = "UNKNOWN";
    IPAddress = null;

    // Game
    Username = "UNKNOWN";
    Team = -1; // 3: blue, 2: red, 1: spec, 0: chell //!~
    Alive = false;
    Deaths = 0;
    PotatoGun = false;
    IsBot = false;
    TwoPortals = true;
    EyeAngles = Vector(0,0,0);

    // hooks
    OnEyeAnglesChange = null;

    // Linked Entitys
    LinkedPortals = null;
    LinkedPortalGun = null;
    LinkedViewModel = null;
    LinkedArbitraryObjects = null;

    // Cosmetic
    Color = "255 255 255";

    //-------------
    // Claim Relatives
    //-------------

    claimLinkedPortals = function() {
        local foundPortals = []
        foreach (portal in GetEntListByClassname("prop_portal")) {
            /*New people's portals won't be named.
              This gives us a reduced chance of
              accidentally finding a map portal.*/
            if (portal.GetName() == "") {
                // skip any portals owned by other players
                local badPortal = false;
                foreach (Cplayerclass in GetAllPlayerClasses()) {
                    if (Cplayerclass.LinkedPortals.len() < 2) {
                        printl("How did this happen?? PlayerClasses Linked Portals")
                        continue
                    }
                    if (Cplayerclass.LinkedPortals[0] == portal || Cplayerclass.LinkedPortals[1] == portal) {
                        badPortal = true;
                        break;
                    }
                }

                // if this portal isn't owned by anyone else claim it!
                if (!badPortal) foundPortals.append(portal);
            }
        }

        while (foundPortals.len() < 2) foundPortals.append(null);
        this.LinkedPortals = foundPortals;
    }

    claimPortalGun = function() {
        foreach (portalgun in GetEntListByClassname("weapon_portalgun")) {
            if (portalgun.GetRootMoveParent() == PlayerEntity) LinkedPortalGun = portalgun;
        }
    }

    //-------------------
    // Updates
    //-------------------

    updateEyeAngles = function(eyeangles) {
        EyeAngles = eyeangles
        this.OnEyeAnglesChange.callCallbacks({
            PlayerClass = this
            EyeAngles = eyeangles
        })
    }

    updateDeathStatus = function(isDead) {
        if (isDead) {
            Alive = false;
            Deaths += 1;
        } else {
            Alive = true;
        }
    }

    updateUsername = function(newName) {
        Username = newName;
    }

    updatePortalGun = function(removedportalgun=false, oneportal = false) {
        claimPortalGun()
        if (removedportalgun) {
            LinkedPortalGun = null;
        }
        if (PotatoGun) {
            givePotatoGun()
        } else {
            revokePotatoGun()
        }
        TwoPortals = !oneportal
    }

    //--------------------
    // Game
    //--------------------

    DisplayText = function() {
        
    }
    
    givePotatoGun = function() {
        PotatoGun = true; // we set this to true regardless, we want to have a potatogun, if the player gets it we can handle that intent
        if (LinkedPortalGun == null) return;
        //! we are gonna need to have this automatically detect if we are on the regular portal gun model and change the bodygroup conditionally
        EntFireByHandle(LinkedPortalGun, "SetBodygroup", "1");
    }

    revokePotatoGun = function() {
        PotatoGun = false;
        if (LinkedPortalGun == null) return;
        //! we are gonna need to have this automatically detect if we are on the regular portal gun model and change the bodygroup conditionally
        EntFireByHandle(LinkedPortalGun, "SetBodygroup", "0");
    }

    givePortalGun = function() {
        // Force all players to receive portal gun
        GamePlayerEquip <- Entities.CreateByClassname("game_player_equip")
        SetKeyValue(GamePlayerEquip, "weapon_portalgun", "1")
        local p = null
        while (p = Entities.FindByClassname(p, "player")) {
            EntFireByHandle(GamePlayerEquip, "use", "", 0, p, p)
        }
        GamePlayerEquip.Destroy()

        // Enable secondary fire for all guns
        EntFire("weapon_portalgun", "addoutput", "CanFirePortal2 1", 0, null)
        a1AlreadyGavePortalGun <- true
    }

    sendCommand = function(command, delay = 0) {
        EntFireByHandle(sharedents.point_clientcommand, "Command", command, delay, PlayerEntity, PlayerEntity)
    }

    //-----------------
    // Setup
    //-----------------

    disconnect = function() {
        delete playerclasses[EntIndex]
    }

    finalize = function() {
        PlayerEntity = FindPlayerByEntIndex(EntIndex);
        this.LinkedPortals = [null, null]

        claimLinkedPortals();
        claimPortalGun();
        updatePortalGun(); // just incase potatogun got set while joining
        
        FullyInitalized = true;

        custom_hook_player_class_finalize(this)
    }

    constructor(eindx, name, steamid = "UNKNOWN", ipaddr = null, isbot = false) {
        EntIndex = eindx;
        SteamID = steamid;
        Username = name;
        IPAddress = ipaddr;
        IsBot = isbot;
        this.LinkedArbitraryObjects = {};
        this.OnEyeAnglesChange = GenericHook("EyeAngleChange");
    }
}