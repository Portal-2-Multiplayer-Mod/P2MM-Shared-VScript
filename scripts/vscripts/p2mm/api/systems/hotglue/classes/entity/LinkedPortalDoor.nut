hotglue.toolkit.entity.LinkedPortalDoor <- class {
    LinkedPortalDoor1 = null
    LinkedPortalDoor2 = null

    // open func and close func
    openDoor  = function(delay = 0, instant = false) {
        if (!instant) {
            EntFireByHandle(LinkedPortalDoor1, "Open", "", delay)
            EntFireByHandle(LinkedPortalDoor1, "Close", "", delay + 0.05)
            EntFireByHandle(LinkedPortalDoor1, "Open", "", delay + 0.1)
        } else {
            EntFireByHandle(LinkedPortalDoor1, "Open", "", delay)
        }
        
    }

    closeDoor = function(delay = 0) {
        EntFireByHandle(LinkedPortalDoor1, "Close", "", delay)
        EntFireByHandle(LinkedPortalDoor2, "Close", "", delay)
    }
    
    constructor(transform1, transform2, name1 = null, name2 = null) {
        LinkedPortalDoor1 = Entities.CreateByClassname("linked_portal_door")
        LinkedPortalDoor2 = Entities.CreateByClassname("linked_portal_door")

        LinkedPortalDoor1.__KeyValueFromInt("width", transform1.Size.x)
        LinkedPortalDoor2.__KeyValueFromInt("width", transform2.Size.x)

        LinkedPortalDoor1.__KeyValueFromInt("height", transform1.Size.y)
        LinkedPortalDoor2.__KeyValueFromInt("height", transform2.Size.y)

        //* detect if there is a name if not make a generic name
        if (name1 == null) {
            name1 = "P2MM_GenericLinkedPortalDoor_" + UniqueString()
        }

        if (name2 == null) {
            name2 = "P2MM_GenericLinkedPortalDoor_" + UniqueString()
        }

        LinkedPortalDoor1.__KeyValueFromString("targetname", name1)
        LinkedPortalDoor2.__KeyValueFromString("targetname", name2)

        LinkedPortalDoor1.__KeyValueFromString("partnername", name2)
        LinkedPortalDoor2.__KeyValueFromString("partnername", name1)

        SetLocation(LinkedPortalDoor1, transform1)
        SetLocation(LinkedPortalDoor2, transform2)

        InitializeEntity(LinkedPortalDoor1)
        InitializeEntity(LinkedPortalDoor2)
    }
}