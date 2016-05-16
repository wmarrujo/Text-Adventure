public class Food: Item {
    
    override class var identifiers: Set<String> { return super.identifiers.union(["food"]) }
    
    ////////////////////////////////////////////////////////////////
    // INSTANCE VARIABLES
    ////////////////////////////////////////////////////////////////
    
    
    
    ////////////////////////////////////////////////////////////////
    // INITIALIZATION
    ////////////////////////////////////////////////////////////////
    
    // TODO: uncomment when it changes anything from the init of Item (it's superclass)
    /*init(named name: String, withDescription description: String = "", andWeight weight: Int, withAttributes attributes: [String] = []) {
        super.init(named: name, withDescription: description, andWeight: weight, withAttributes: attributes)
    }*/
    
    ////////////////////////////////////////////////////////////////
    // METHODS
    ////////////////////////////////////////////////////////////////
    
    func consume(caller: Player) {
        
    }
    
}