public class Item: Thing {
    
    ////////////////////////////////////////////////////////////////
    // INSTANCE VARIABLES
    ////////////////////////////////////////////////////////////////
    
    var weight: Int
    var attributes: [String] // adjectives that discribe it
    
    ////////////////////////////////////////////////////////////////
    // INITIALIZATION
    ////////////////////////////////////////////////////////////////
    
    init(named name: String, withDescription description: String = "", andWeight weight: Int, withAttributes attributes: [String] = []) {
        self.weight = weight
        self.attributes = attributes
        super.init(name, description)
    }
    
    ////////////////////////////////////////////////////////////////
    // METHODS
    ////////////////////////////////////////////////////////////////
    
    // STATUS
    
    // INTERACTIONS
    
    func perform(command: String) {
        /*switch command {
            default:
                // message("I don't know how to do that")
        }*/
    }
    
    // ACTIONS
    
}