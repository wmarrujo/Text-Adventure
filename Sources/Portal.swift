public class Portal: Thing {
    
    ////////////////////////////////////////////////////////////////
    // INSTANCE VARIABLES
    ////////////////////////////////////////////////////////////////
    
    var connection: (Location, Location)
    
    ////////////////////////////////////////////////////////////////
    // INITIALIZATION
    ////////////////////////////////////////////////////////////////
    
    init(named name: String, withDescription description: String = "", from: Location, to: Location) {
        self.connection = (from, to)
        super.init(name, description)
    }
    
    ////////////////////////////////////////////////////////////////
    // METHODS
    ////////////////////////////////////////////////////////////////
    
    func traverse(caller: Automata, from previousLocation: Location) { // does the moving
        let destination: Location
        if self.connection.0 == previousLocation { // came from connection.1 location
            destination = self.connection.1
        } else { // came from connection.2 location
            destination = self.connection.0
        }
        
        caller.location = destination // update caller's location
        destination.enter(caller) // update location's contained automata
    }
    
}