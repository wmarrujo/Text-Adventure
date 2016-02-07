public class Creature: Thing {

    ////////////////////////////////////////////////////////////////
    // INSTANCE VARIABLES
    ////////////////////////////////////////////////////////////////
    
    var health: Int
    var location: Location
    var encumbrance: Int
    var inventory: Set<Item>

    ////////////////////////////////////////////////////////////////
    // INITIALIZATION
    ////////////////////////////////////////////////////////////////

    init(named name: String, andDescription description: String = "", withHealth health: Int, atLocation location: Location, withEncumbrence encumbrance: Int, withInventoryOf inventory: Set<Item> = []) {
        self.health = health
        self.location = location
        self.encumbrance = encumbrance
        self.inventory = inventory
        super.init(name, description)
    }

    ////////////////////////////////////////////////////////////////
    // METHODS
    ////////////////////////////////////////////////////////////////
    
    func move(direction: String) {
        self.location.go(direction, by: self)
    }
    
}
