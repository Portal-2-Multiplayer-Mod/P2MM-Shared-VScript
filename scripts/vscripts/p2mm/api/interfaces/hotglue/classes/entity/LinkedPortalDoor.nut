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

        SetKeyValue(LinkedPortalDoor1, "width", transform1.Size.x)
        SetKeyValue(LinkedPortalDoor2, "width", transform2.Size.x)

        SetKeyValue(LinkedPortalDoor1, "height", transform1.Size.y)
        SetKeyValue(LinkedPortalDoor2, "height", transform2.Size.y)

        //* detect if there is a name if not make a generic name
        if (name1 == null) {
            name1 = "P2MM_GenericLinkedPortalDoor_" + UniqueString()
        }

        if (name2 == null) {
            name2 = "P2MM_GenericLinkedPortalDoor_" + UniqueString()
        }

        SetKeyValue(LinkedPortalDoor1, "targetname", name1)
        SetKeyValue(LinkedPortalDoor2, "targetname", name2)

        SetKeyValue(LinkedPortalDoor1, "partnername", name2)
        SetKeyValue(LinkedPortalDoor2, "partnername", name1)

        SetLocation(LinkedPortalDoor1, transform1)
        SetLocation(LinkedPortalDoor2, transform2)

        InitializeEntity(LinkedPortalDoor1)
        InitializeEntity(LinkedPortalDoor2)
    }
}