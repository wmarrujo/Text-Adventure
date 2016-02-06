public class Location: Thing {
    
    ////////////////////////////////////////////////////////////////
    // INSTANCE VARIABLES
    ////////////////////////////////////////////////////////////////
    
    var automata: Set<Automata>
    var contents: Set<Item>
    var directions: [String:Portal?]
    
    ////////////////////////////////////////////////////////////////
    // INITIALIZATION
    ////////////////////////////////////////////////////////////////
    
    init(named name: String, withDescription description: String = "", withAutomata automata: Set<Automata> = [], withContents contents: Set<Item> = [], withUpExit up: Portal? = nil, withDownExit down: Portal? = nil, withNorthExit north: Portal? = nil, withSouthExit south: Portal? = nil, withEastExit east: Portal? = nil, withWestExit west: Portal? = nil) {
        self.automata = automata
        self.contents = contents
        self.directions = ["up":up, "down":down, "north":north, "south":south, "east":east, "west":west]
        super.init(name, description)
    }
    
    ////////////////////////////////////////////////////////////////
    // METHODS
    ////////////////////////////////////////////////////////////////
    
    // STATUS
    
    func findItemsWithRule(rule: (Item) -> Bool) -> Set<Item> {
        var items: Set<Item> = []
        for item in self.contents {
            if rule(item) { // if item matches rule
                items.insert(item)
            }
        }
        return items
    }
    
    override func showDescription() -> String {
        var description = self.description
        if !self.contents.isEmpty {
            description += "\n You see around you:"
            for item in self.contents {
                description += "\n\t" + item.showDescription()
            }
        }
        if !self.automata.isEmpty {
            description += "\n here with you is:"
            for automata in self.automata {
                description += "\n\t" + automata.showDescription()
            }
        }
        return description
    }
    
    // INTERACTIONS
    
    func perform(command: String, toItems items: Set<Item>) {
        /*switch command {
            case "?":
                
            default:
                message("I don't know how to do that")
        }*/
    }
    
    // ACTIONS
    
    // Movement
    
    func enter(automata: Automata) { // called when an automata enters a location
        self.automata.insert(automata)
    }
    
    func go(direction: String, by caller: Automata) {
        if let portal = directions[direction]! { // can go that way
            // TODO: call exit from this location
            portal.traverse(caller, from: self)
        } else { // can't go that way
            message("you can't go that way")
        }
    }
    
}