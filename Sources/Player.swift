public class Player: Sentient {
    
    ////////////////////////////////////////////////////////////////
    // INSTANCE VARIABLES
    ////////////////////////////////////////////////////////////////
    
    
    
    ////////////////////////////////////////////////////////////////
    // INITIALIZATION
    ////////////////////////////////////////////////////////////////
    
    init(withName name: String, andDscription description: String, withHealth health: Int, atLocation location: Location, withEncumbrence encumbrance: Int, withInventoryOf inventory: Set<Item> = []) {
        super.init(withName: name, andDscription: description, withHealth: health, atLocation: location, withEncumbrence: encumbrance, withInventoryOf: inventory)
    }
    
    ////////////////////////////////////////////////////////////////
    // METHODS
    ////////////////////////////////////////////////////////////////
    
    // STATUS
    
    func findItemsWithRule(rule: (Item) -> Bool) -> Set<Item> {
        var items: Set<Item> = []
        for item in self.inventory {
            if rule(item) { // if item matches rule
                items.insert(item)
            }
        }
        items.union(self.location.findItemsWithRule( rule))
        return items
    }
    
    // INTERACTIONS
    
    func perform(command: String, toItems items: Set<Item>? = nil) {
        for item in items { // FIXME: how to tak inventory
            item.perform(command)
        }
    }
    
    // ACTIONS
    
}