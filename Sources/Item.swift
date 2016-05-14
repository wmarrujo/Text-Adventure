import SwiftyJSON

public class Item: Thing {
    
    override class var identifiers: Set<String> { return super.identifiers.union(["item"]) }
    
    ////////////////////////////////////////////////////////////////
    // INSTANCE VARIABLES
    ////////////////////////////////////////////////////////////////
    
    var weight: Int
    var attributes: [String] // adjectives that describe it
    
    // REFERENCES BY ID
    
    var placementIDs: [String:Set<Int>]
    
    // ACCESSOR REFERENCES
    
    var placement: [String:Set<Item>] {
        get {
            var placement: [String:Set<Item>] = [:]
            
            for (location, idSet) in self.placementIDs {
                placement[location] = Set(idSet.map({ self.game.getThingByID($0) as! Item }))
            }
            
            return placement
        }
        set {
            for (location, itemSet) in newValue {
                placementIDs[location] = Set(itemSet.map({ $0.id }))
            }
        }
    }
    
    ////////////////////////////////////////////////////////////////
    // INITIALIZATION
    ////////////////////////////////////////////////////////////////
    
    init(inGame game: Game, withID id: Int? = nil, named name: String, withDescription description: String = "", andWeight weight: Int, withAttributes attributes: [String] = [], withItemsAbove aboveIDs: [Int] = [], withItemsBelow belowIDs: [Int] = [], withItemsAround aroundIDs: [Int] = []) {
        self.weight = weight
        self.attributes = attributes
        self.placementIDs = ["above":Set(aboveIDs), "below":Set(belowIDs), "around":Set(aroundIDs)]
        super.init(inGame: game, withID: id, named: name, withDescription: description)
    }
    
    ////////////////////////////////////////////////////////////////
    // ARCHIVING
    ////////////////////////////////////////////////////////////////
    
    // ENCODE OBJECT TO JSON
    
    override func toJson() -> JSON {
        var json: JSON = [:]
        
        json["id"] = JSON(self.id)
        json["type"] = JSON("Item")
        json["name"] = JSON(self.name)
        json["description"] = JSON(self.description)
        json["weight"] = JSON(self.weight)
        json["attributes"] = JSON(self.attributes)
        json["placement"]["above"] = JSON(Array(self.placementIDs["above"]!))
        json["placement"]["below"] = JSON(Array(self.placementIDs["below"]!))
        json["placement"]["around"] = JSON(Array(self.placementIDs["around"]!))
        
        return json
    }
    
    // DECODE OBJECT FROM JSON
    
    convenience init(inGame game: Game, fromJSON json: JSON) {
        let id = json["id"].intValue
        let name = json["name"].stringValue
        let description = json["description"].stringValue
        let weight = json["weight"].intValue
        let attributes = json["attributes"].arrayValue.map({ $0.stringValue })
        let aboveIDs = json["placement"]["above"].arrayValue.map({ $0.intValue })
        let belowIDs = json["placement"]["below"].arrayValue.map({ $0.intValue })
        let aroundIDs = json["placement"]["around"].arrayValue.map({ $0.intValue })
        
        self.init(inGame: game, withID: id, named: name, withDescription: description, andWeight: weight, withAttributes: attributes, withItemsAbove: aboveIDs, withItemsBelow: belowIDs, withItemsAround: aroundIDs)
    }
    
    ////////////////////////////////////////////////////////////////
    // METHODS
    ////////////////////////////////////////////////////////////////
    
    // STATUS
    
    // INTERACTIONS
    
    // ACTIONS
    
}
