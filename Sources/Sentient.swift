public class Sentient: Automata {
    
    ////////////////////////////////////////////////////////////////
    // INSTANCE VARIABLES
    ////////////////////////////////////////////////////////////////
    
    var encumbrance: Int
    var inventory: Set<Item>
    
    ////////////////////////////////////////////////////////////////
    // INITIALIZATION
    ////////////////////////////////////////////////////////////////
    
    init(named name: String, andDscription description: String = "", withHealth health: Int, atLocation location: Location, withEncumbrence encumbrance: Int, withInventoryOf inventory: Set<Item> = []) {
        self.encumbrance = encumbrance
        self.inventory = inventory
        super.init(named: name, andDscription: description, withHealth: health, atLocation: location)
    }
    
    ////////////////////////////////////////////////////////////////
    // METHODS
    ////////////////////////////////////////////////////////////////
    
    // TODO: show inventory function - tell description of each
    // TODO: look function - read description of room
    // TODO: look item function - read description of item
    
}