public class Container: Item {
    
    override class var identifiers: Set<String> { return super.identifiers.union(["container"]) }
    
    ////////////////////////////////////////////////////////////////
    // INSTANCE VARIABLES
    ////////////////////////////////////////////////////////////////
    
    var contents: Set<Item>
    
    ////////////////////////////////////////////////////////////////
    // INITIALIZATION
    ////////////////////////////////////////////////////////////////
    
    init(named name: String, withDescription description: String = "", andWeight weight: Int, withAttributes attributes: [String] = [], withContents contents: Set<Item> = []) {
        self.contents = contents
        super.init(named: name, withDescription: description, andWeight: weight, withAttributes: attributes)
    }
    
    ////////////////////////////////////////////////////////////////
    // METHODS
    ////////////////////////////////////////////////////////////////
    
    
    
}