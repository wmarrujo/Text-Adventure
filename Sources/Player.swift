public class Player: Sentient {
    
    ////////////////////////////////////////////////////////////////
    // INSTANCE VARIABLES
    ////////////////////////////////////////////////////////////////
    
    
    
    ////////////////////////////////////////////////////////////////
    // INITIALIZATION
    ////////////////////////////////////////////////////////////////
    
    /*init(withName name: String, andDscription description: String = "", withHealth health: Int, atLocation location: Location, withEncumbrence encumbrance: Int, withInventoryOf inventory: Set<Item> = []) {
        super.init(withName: name, andDscription: description, withHealth: health, atLocation: location, withEncumbrence: encumbrance, withInventoryOf: inventory)
    }*/
    
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
        return items.union(self.location.findItemsWithRule( rule))
    }
    
    
    // INTERACTIONS
    
    func perform(command: String) { // perform a command on the player
        /*switch command {
            case "?":
                
            default:
                
        }*/
    }
    
    func perform(command: String, toItems items: Set<Item>) { // perform a command on certain items
        for item in items { // FIXME: how to take inventory
            item.perform(command)
        }
    }
    
    // ACTIONS
    
}