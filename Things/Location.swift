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
    
    init(withName name: String, andDescription description: String, withAutomata automata: Set<Automata> = [], withContents contents: Set<Item> = [], withUpExit up: Portal? = nil, withDownExit down: Portal? = nil, withNorthExit north: Portal? = nil, withSouthExit south: Portal? = nil, withEastExit east: Portal? = nil, withWestExit west: Portal? = nil) {
        self.automata = automata
        self.contents = contents
        self.directions = ["up":up, "down":down, "north":north, "south":south, "east":east, "west":west]
        super.init(name, description)
    }
    
    ////////////////////////////////////////////////////////////////
    // METHODS
    ////////////////////////////////////////////////////////////////
    
    func enter(automata: Automata) { // called when an automata enters a location
        self.automata.add(automata)
    }
    
    func go(direction: String, by caller: Automata) {
        if let portal = directions[direction]? { // can go that way
            portal.traverse(caller, from: self)
        } else { // can't go that way
            // send a message
        }
    }
    
}