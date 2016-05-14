import SwiftyJSON

public class Container: Item {
    
    override class var identifiers: Set<String> { return super.identifiers.union(["container"]) }
    
    ////////////////////////////////////////////////////////////////
    // INSTANCE VARIABLES
    ////////////////////////////////////////////////////////////////
    
    // REFERENCES BY ID
    
    var contentIDs: Set<Int>
    
    // ACCESSOR REFERENCES
    
    var contents: Set<Item> {
        get {
            var contents: Set<Item> = []
            
            for id in self.contentIDs {
                contents.insert(self.game.getThingByID(id) as! Item)
            }
            
            return contents
        }
        set {
            var newIDs: Set<Int> = []
            
            for item in newValue {
                newIDs.insert(item.id)
            }
            
            self.contentIDs = newIDs
        }
    }
    
    ////////////////////////////////////////////////////////////////
    // INITIALIZATION
    ////////////////////////////////////////////////////////////////
    
    init(inGame game: Game, withID id: Int? = nil, named name: String, withDescription description: String = "", andWeight weight: Int, withAttributes attributes: [String] = [], withContents contentIDs: [Int] = [], withItemsAbove aboveIDs: [Int] = [], withItemsBelow belowIDs: [Int] = [], withItemsAround aroundIDs: [Int] = []) {
        self.contentIDs = Set(contentIDs)
        super.init(inGame: game, withID: id, named: name, withDescription: description, andWeight: weight, withAttributes: attributes, withItemsAbove: aboveIDs, withItemsBelow: belowIDs, withItemsAround: aroundIDs)
    }
    
    ////////////////////////////////////////////////////////////////
    // ARCHIVING
    ////////////////////////////////////////////////////////////////
    
    // ENCODE OBJECT TO JSON
    
    override func toJSON() -> JSON {
        var json: JSON = [:]
        
        json["id"] = JSON(self.id)
        json["type"] = JSON("Container")
        json["name"] = JSON(self.name)
        json["description"] = JSON(self.description)
        json["weight"] = JSON(self.weight)
        json["attributes"] = JSON(self.attributes)
        json["placement"]["above"] = JSON(Array(self.placementIDs["above"]!))
        json["placement"]["below"] = JSON(Array(self.placementIDs["below"]!))
        json["placement"]["around"] = JSON(Array(self.placementIDs["around"]!))
        json["contents"] = JSON(Array(self.contentIDs))
        
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
        let contentIDs = json["contents"].arrayValue.map({ $0.intValue })
        
        self.init(inGame: game, withID: id, named: name, withDescription: description, andWeight: weight, withAttributes: attributes, withItemsAbove: aboveIDs, withItemsBelow: belowIDs, withItemsAround: aroundIDs, withContents: contentIDs)
    }
    
    ////////////////////////////////////////////////////////////////
    // METHODS
    ////////////////////////////////////////////////////////////////
    
    
    
}