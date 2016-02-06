public class Sentient: Automata {

    ////////////////////////////////////////////////////////////////
    // INSTANCE VARIABLES
    ////////////////////////////////////////////////////////////////

    var encumbrance: Int
    var inventory: Set<Item>

    ////////////////////////////////////////////////////////////////
    // INITIALIZATION
    ////////////////////////////////////////////////////////////////
<<<<<<< HEAD

    init(withName name: String, andDescription description: String = "", withHealth health: Int, atLocation location: Location, withEncumbrence encumbrance: Int, withInventoryOf inventory: Set<Item> = []) {
        self.encumbrance = encumbrance
        self.inventory = inventory
        super.init(withName: name, andDescription: description, withHealth: health, atLocation: location)
=======
    
    init(named name: String, andDscription description: String = "", withHealth health: Int, atLocation location: Location, withEncumbrence encumbrance: Int, withInventoryOf inventory: Set<Item> = []) {
        self.encumbrance = encumbrance
        self.inventory = inventory
        super.init(named: name, andDscription: description, withHealth: health, atLocation: location)
>>>>>>> ec7b2a1854f4d56c2aba428c6e50abdd5b556642
    }

    ////////////////////////////////////////////////////////////////
    // METHODS
    ////////////////////////////////////////////////////////////////
<<<<<<< HEAD



}
=======
    
    // TODO: show inventory function - tell description of each
    // TODO: look function - read description of room
    // TODO: look item function - read description of item
    
}
>>>>>>> ec7b2a1854f4d56c2aba428c6e50abdd5b556642
