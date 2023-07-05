hotglue.toolkit.entity.LinkedPortalDoor <- class {
    Entity1 = null
    Entity2 = null

    // open func and close func
    openDoor  = function(delay = 0, instant = false) {
        if (!instant) {
            EntFireByHandle(Entity1, "Open", "", delay)
            EntFireByHandle(Entity1, "Close", "", delay + 0.05)
            EntFireByHandle(Entity1, "Open", "", delay + 0.1)
        } else {
            EntFireByHandle(Entity1, "Open", "", delay)
        }
        
    }

    closeDoor = function(delay = 0) {
        EntFireByHandle(Entity1, "Close", "", delay)
        EntFireByHandle(Entity2, "Close", "", delay)
    }
    
    constructor(transform1, transform2, name1 = null, name2 = null) {
        Entity1 = Entities.CreateByClassname("linked_portal_door")
        Entity2 = Entities.CreateByClassname("linked_portal_door")

        SetKeyValue(Entity1, "width", transform1.Size.x)
        SetKeyValue(Entity2, "width", transform2.Size.x)

        SetKeyValue(Entity1, "height", transform1.Size.y)
        SetKeyValue(Entity2, "height", transform2.Size.y)

        //* detect if there is a name if not make a generic name
        if (name1 == null) {
            name1 = "P2MM_GenericLinkedPortalDoor_" + UniqueString()
        }

        if (name2 == null) {
            name2 = "P2MM_GenericLinkedPortalDoor_" + UniqueString()
        }

        SetKeyValue(Entity1, "targetname", name1)
        SetKeyValue(Entity2, "targetname", name2)

        SetKeyValue(Entity1, "partnername", name2)
        SetKeyValue(Entity2, "partnername", name1)

        SetLocation(Entity1, transform1)
        SetLocation(Entity2, transform2)

        InitializeEntity(Entity1)
        InitializeEntity(Entity2)
    }
}