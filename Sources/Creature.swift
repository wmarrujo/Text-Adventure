import SwiftyJSON

public class Creature: Thing {
    
    override class var identifiers: Set<String> { return super.identifiers.union(["food"]) }

    ////////////////////////////////////////////////////////////////
    // INSTANCE VARIABLES
    ////////////////////////////////////////////////////////////////

    var health: Int
    var encumbrance: Int
    
    // REFERENCES BY ID
    
    var locationID: Int
    var inventoryIDs: Set<Int>
    
    // ACCESSOR REFERENCES
    
    var location: Location {
        get {
            return self.game.getThingByID(self.locationID) as! Location
        }
        set {
            self.locationID = newValue.id
        }
    }
    
    var inventory: Set<Item> {
        get {
            var inventory: Set<Item> = []
            
            for id in self.inventoryIDs {
                inventory.insert(self.game.getThingByID(id) as! Item)
            }
            
            return inventory
        }
        set {
            var newIDs: Set<Int> = []
            
            for item in newValue {
                newIDs.insert(item.id)
            }
            
            self.inventoryIDs = newIDs
        }
    }

    ////////////////////////////////////////////////////////////////
    // INITIALIZATION
    ////////////////////////////////////////////////////////////////
    
    init(inGame game: Game, withID id: Int? = nil, named name: String, withDescription description: String = "", withHealth health: Int, atLocation locationID: Int, withEncumbrance encumbrance: Int, withInventoryOf inventoryIDs: [Int] = []) {
        self.health = health
        self.locationID = locationID
        self.encumbrance = encumbrance
        self.inventoryIDs = Set(inventoryIDs)
        super.init(inGame: game, withID: id, named: name, withDescription: description)
    }
    
    ////////////////////////////////////////////////////////////////
    // ARCHIVING
    ////////////////////////////////////////////////////////////////
    
    // ENCODE OBJECT TO JSON
    
    override func toJson() -> JSON {
        var json: JSON = [:]
        
        json["id"] = JSON(self.id)
        json["type"] = JSON("Thing")
        json["name"] = JSON(self.name)
        json["description"] = JSON(self.description)
        json["health"] = JSON(self.health)
        json["encumbrance"] = JSON(self.encumbrance)
        json["location"] = JSON(self.locationID)
        json["inventory"] = JSON(Array(self.inventoryIDs))
        
        return json
    }
    
    // DECODE OBJECT FROM JSON
    
    convenience init(inGame game: Game, fromJSON json: JSON) {
        let id = json["id"].intValue
        let name = json["name"].stringValue
        let description = json["description"].stringValue
        let health = json["health"].intValue
        let locationID = json["locationID"].intValue
        let encumbrance = json["encumbrance"].intValue
        let inventoryIDs = json["inventory"].arrayValue.map({ $0.intValue })
        
        self.init(inGame: game, withID: id, named: name, withDescription: description, withHealth: health, atLocation: locationID, withEncumbrance: encumbrance, withInventoryOf: inventoryIDs)
    }

    ////////////////////////////////////////////////////////////////
    // METHODS
    ////////////////////////////////////////////////////////////////

    func move(direction: String) {
        self.location.go(direction, by: self)
    }
    
    func showInventory() -> String {
        var string = ""
        
        if self.inventory.isEmpty {
            string = "Inventory Empty"
        } else {
            string = "Inventory"
            
            for item in self.inventory {
                string += "\n- " + item.name
            }
        }
        
        return string
    }

}
