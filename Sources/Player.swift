import Foundation
import SwiftyJSON

public class Player: Creature {
    
    override class var identifiers: Set<String> { return super.identifiers.union(["player"]) }
    
    ////////////////////////////////////////////////////////////////
    // INSTANCE VARIABLES
    ////////////////////////////////////////////////////////////////
    
    
    
    ////////////////////////////////////////////////////////////////
    // INITIALIZATION
    ////////////////////////////////////////////////////////////////
    
    /*init(named name: String, andDescription description: String = "", withHealth health: Int, atLocation location: Location, withEncumbrence encumbrance: Int, withInventoryOf inventory: Set<Item> = []) {
        super.init(named: name, andDescription: description, withHealth: health, atLocation: location, withEncumbrence: encumbrance, withInventoryOf: inventory)
    }*/
    
    ////////////////////////////////////////////////////////////////
    // ARCHIVING
    ////////////////////////////////////////////////////////////////
    
    // ENCODE OBJECT TO JSON
    
    override func toJson() -> JSON {
        var json: JSON = [:]
        
        json["id"] = JSON(self.id)
        json["type"] = JSON("Player")
        json["name"] = JSON(self.name)
        json["description"] = JSON(self.description)
        json["health"] = JSON(self.health)
        json["encumbrance"] = JSON(self.encumbrance)
        json["location"] = JSON(self.locationID)
        json["inventory"] = JSON(Array(self.inventoryIDs))
        
        return json
    }
    
    // DECODE OBJECT FROM JSON
    
    // uses same as superclass
    
    ////////////////////////////////////////////////////////////////
    // METHODS
    ////////////////////////////////////////////////////////////////
    
    // STATUS
    
    // ACTIONS
    
}