public class Portal: Item {
    
    ////////////////////////////////////////////////////////////////
    // INSTANCE VARIABLES
    ////////////////////////////////////////////////////////////////
    
    var connection: (Location, Location)
    
    ////////////////////////////////////////////////////////////////
    // INITIALIZATION
    ////////////////////////////////////////////////////////////////
    
    init(named name: String, withDescription description: String, from: Location, to: Location) {
        let connection = (from, to)
        super.init(name, description)
    }
    
    ////////////////////////////////////////////////////////////////
    // METHODS
    ////////////////////////////////////////////////////////////////
    
    func traverse(caller: Automata, from: Location) { // does the moving
        if self.connection.1 == from { // came from connection.1 location
            let otherLocation = self.connection.2
        } else { // came from connection.2 location
            let otherLocation = self.connection.1
        }
        
        otherLocation.enter(caller)
    }
    
}