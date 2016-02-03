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
    
    func goUp(caller: Automata) {
        directions["up"].traverse(caller)
    }
    
    func goDown(caller: Automata) {
        directions["down"].traverse(caller)
    }
    
    func goNorth(caller: Automata) {
        directions["north"].traverse(caller)
    }
    
    func goSouth(caller: Automata) {
        directions["south"].traverse(caller)
    }
    
    func goEast(caller: Automata) {
        directions["east"].traverse(caller)
    }
    
    func goWest(caller: Automata) {
        directions["west"].traverse(caller)
    }
    
}