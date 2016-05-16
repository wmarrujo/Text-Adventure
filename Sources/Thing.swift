import SwiftyJSON

public class Thing: Equatable, Hashable {
    
    class var identifiers: Set<String> { return ["thing"] }
    
    ////////////////////////////////////////////////////////////////
    // INSTANCE VARIABLES
    ////////////////////////////////////////////////////////////////
    
    let id: Int // unique persistent identifier
    var game: Game // reference to the game object, so it can find other objects in the game by id
    
    var name: String // more of an "identifier" than a "name" really
    var description: String // what gets printed out
    
    // Hashable Conformity
    
    public var hashValue: Int { return self.id }
    
    ////////////////////////////////////////////////////////////////
    // INITIALIZATION
    ////////////////////////////////////////////////////////////////
    
    init(inGame game: Game, withID id: Int? = nil, named name: String, withDescription description: String = "") {
        self.game = game
        if let i = id { // id set explicitly
            self.id = i // use that one
        } else { // id not set explicitly
            self.id = game.nextID() // use next one in game
        }
        self.name = name
        self.description = description
    }
    
    ////////////////////////////////////////////////////////////////
    // ARCHIVING
    ////////////////////////////////////////////////////////////////
    
    // ENCODE OBJECT TO JSON
    
    func toJSON() -> JSON {
        var json: JSON = [:]
        
        json["id"] = JSON(self.id)
        json["type"] = JSON("Thing")
        json["name"] = JSON(self.name)
        json["description"] = JSON(self.description)
        
        return json
    }
    
    // DECODE OBJECT FROM JSON
    
    convenience init(inGame game: Game, fromJSON json: JSON) {
        let id = json["id"].intValue
        let name = json["name"].stringValue
        let description = json["description"].stringValue
        
        self.init(inGame: game, withID: id, named: name, withDescription: description)
    }

    ////////////////////////////////////////////////////////////////
    // METHODS
    ////////////////////////////////////////////////////////////////
    
    func showName() -> String {
        return self.name
    }
    
    func showDescription() -> String {
        return self.description
    }
    
}

////////////////////////////////////////////////////////////////
// EXTERNAL DEPENDENCIES
////////////////////////////////////////////////////////////////

public func ==(lhs: Thing, rhs: Thing) -> Bool {
  return lhs.id == rhs.id // the ids *should* be unique
}
