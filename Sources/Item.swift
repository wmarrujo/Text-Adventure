public class Item: Thing {
    
    override class var identifiers: Set<String> { return super.identifiers.union(["item"]) }
    
    ////////////////////////////////////////////////////////////////
    // INSTANCE VARIABLES
    ////////////////////////////////////////////////////////////////
    
    var weight: Int
    var attributes: [String] // adjectives that describe it
    var placement: [String:Set<Item>]
    
    ////////////////////////////////////////////////////////////////
    // INITIALIZATION
    ////////////////////////////////////////////////////////////////
    
    init(named name: String, withDescription description: String = "", andWeight weight: Int, withAttributes attributes: [String] = [], withItemAbove above: Set<Item> = [], withItemBelow below: Set<Item> = [], withItemsAround around: Set<Item> = []) {
        self.weight = weight
        self.attributes = attributes
        self.placement = ["above":above, "below":below, "around":around]
        super.init(name, description)
    }
    
    ////////////////////////////////////////////////////////////////
    // METHODS
    ////////////////////////////////////////////////////////////////
    
    // STATUS
    
    // INTERACTIONS
    
    // ACTIONS
    
}
