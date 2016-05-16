import SwiftyJSON

public class Portal: Thing {
    
    ////////////////////////////////////////////////////////////////
    // INSTANCE VARIABLES
    ////////////////////////////////////////////////////////////////
    
    // REFERENCES BY ID
    
    var connectionIDs: (Int, Int)
    
    // ACCESSOR REFERENCES
    
    var connection: (Location, Location) {
        get {
            return (self.game.getThingByID(self.connectionIDs.0) as! Location, self.game.getThingByID(self.connectionIDs.1) as! Location)
        }
        set {
            self.connectionIDs = (newValue.0.id, newValue.1.id)
        }
    }
    
    ////////////////////////////////////////////////////////////////
    // INITIALIZATION
    ////////////////////////////////////////////////////////////////
    
    init(inGame game: Game, withID id: Int? = nil, named name: String, withDescription description: String = "", from: Int, to: Int) {
        self.connectionIDs = (from, to)
        super.init(inGame: game, withID: id, named: name, withDescription: description)
    }
    
    ////////////////////////////////////////////////////////////////
    // ARCHIVING
    ////////////////////////////////////////////////////////////////
    
    // ENCODE OBJECT TO JSON
    
    override func toJSON() -> JSON {
        var json: JSON = [:]
        
        json["id"] = JSON(self.id)
        json["type"] = JSON("Thing")
        json["name"] = JSON(self.name)
        json["description"] = JSON(self.description)
        json["connection0"] = JSON(self.connectionIDs.0)
        json["connection1"] = JSON(self.connectionIDs.1)
        
        return json
    }
    
    // DECODE OBJECT FROM JSON
    
    convenience init(inGame game: Game, fromJSON json: JSON) {
        let id = json["id"].intValue
        let name = json["name"].stringValue
        let description = json["description"].stringValue
        let connection0 = json["connection0"].intValue
        let connection1 = json["connection1"].intValue
        
        self.init(inGame: game, withID: id, named: name, withDescription: description, from: connection0, to: connection1)
    }
    
    ////////////////////////////////////////////////////////////////
    // METHODS
    ////////////////////////////////////////////////////////////////
    
    func traverse(caller: Creature, from previousLocation: Location) { // does the moving
        let destination: Location
        if self.connection.0 == previousLocation { // came from connection.1 location
            destination = self.connection.1
        } else { // came from connection.2 location
            destination = self.connection.0
        }
        
        caller.location = destination // update caller's location
        previousLocation.exit(caller) // update previous location's contained creatures
        destination.enter(caller) // update location's contained creatures
    }
    
}