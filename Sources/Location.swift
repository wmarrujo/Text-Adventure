import SwiftyJSON

public class Location: Thing {
    
    ////////////////////////////////////////////////////////////////
    // INSTANCE VARIABLES
    ////////////////////////////////////////////////////////////////
    
    // REFERENCES BY ID
    
    var creatureIDs: Set<Int>
    var contentIDs: Set<Int>
    var directionIDs: [String:Int?]
    
    // ACCESSOR REFERENCES
    
    var creatures: Set<Creature> {
        get {
            var creatures: Set<Creature> = []
            
            for id in self.creatureIDs {
                creatures.insert(self.game.getThingByID(id) as! Creature)
            }
            
            return creatures
        }
        set {
            var newIDs: Set<Int> = []
            
            for creature in newValue { // go through all creatures
                newIDs.insert(creature.id) // save their ids
            }
            
            self.creatureIDs = newIDs
        }
    }
    
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
    
    var directions: [String:Portal?] {
        get {
            var directions: [String:Portal?] = [:]
            
            for (direction, id) in self.directionIDs {
                directions[direction] = self.game.getThingByID(id) as? Portal
            }
            
            return directions
        }
        set {
            for (direction, portal) in newValue {
                self.directionIDs[direction] = portal?.id
            }
        }
    }
    
    ////////////////////////////////////////////////////////////////
    // INITIALIZATION
    ////////////////////////////////////////////////////////////////
    
    init(inGame game: Game, withID id: Int? = nil, named name: String, withDescription description: String = "", withCreatures creatureIDs: [Int] = [], withContents contentIDs: [Int] = [], withUpExit upID: Int? = nil, withDownExit downID: Int? = nil, withNorthExit northID: Int? = nil, withSouthExit southID: Int? = nil, withEastExit eastID: Int? = nil, withWestExit westID: Int? = nil, withNorthwestExit northwestID: Int? = nil, withNortheastExit northeastID: Int? = nil, withSouthwestExit southwestID: Int? = nil, withSoutheastExit southeastID: Int? = nil) {
        self.creatureIDs = Set(creatureIDs)
        self.contentIDs = Set(contentIDs)
        self.directionIDs = ["up":upID, "down":downID, "north":northID, "south":southID, "east":eastID, "west":westID, "northwest":northwestID, "northeast":northeastID, "southwest":southwestID, "southeast":southeastID]
        super.init(inGame: game, withID: id, named: name, withDescription: description)
    }
    
    ////////////////////////////////////////////////////////////////
    // ARCHIVING
    ////////////////////////////////////////////////////////////////
    
    // ENCODE OBJECT TO JSON
    
    override func toJSON() -> JSON {
        var json: JSON = [:]
        
        json["id"] = JSON(self.id)
        json["type"] = JSON("Location")
        json["name"] = JSON(self.name)
        json["description"] = JSON(self.description)
        json["creatures"] = JSON(Array(self.creatureIDs))
        json["contents"] = JSON(Array(self.contentIDs))
        json["directions"] = JSON(self.directionIDs.mapValues({ if $0 != nil { return JSON($0!) } else { return nil } }))
        
        return json
    }
    
    // DECODE OBJECT FROM JSON
    
    convenience init(inGame game: Game, fromJSON json: JSON) {
        let id = json["id"].intValue
        let name = json["name"].stringValue
        let description = json["description"].stringValue
        let creatureIDs = json["creatures"].arrayValue.map({ $0.intValue })
        let contentIDs = json["contents"].arrayValue.map({ $0.intValue })
        let upID = json["directions"]["up"].int
        let downID = json["directions"]["down"].int
        let northID = json["directions"]["north"].int
        let southID = json["directions"]["south"].int
        let eastID = json["directions"]["east"].int
        let westID = json["directions"]["west"].int
        let northwestID = json["directions"]["northwest"].int
        let northeastID = json["directions"]["northeast"].int
        let southwestID = json["directions"]["southwest"].int
        let southeastID = json["directions"]["southeast"].int
        
        self.init(inGame: game, withID: id, named: name, withDescription: description, withCreatures: creatureIDs, withContents: contentIDs, withUpExit: upID, withDownExit: downID, withNorthExit: northID, withSouthExit: southID, withEastExit: eastID, withWestExit: westID, withNorthwestExit: northwestID, withNortheastExit: northeastID, withSouthwestExit: southwestID, withSoutheastExit: southeastID)
    }
    
    ////////////////////////////////////////////////////////////////
    // METHODS
    ////////////////////////////////////////////////////////////////
    
    // STATUS
    
    func showDescription(caller: Player) -> String {
        var description = "- " + self.name + " -\n" + self.description
        if !self.contents.isEmpty {
            description += "\n\nYou see around you:"
            for item in self.contents {
                description += "\n\t" + item.description
            }
        }
        if !self.creatures.subtract([caller]).isEmpty {
            description += "\n\nhere with you is:"
            for creature in self.creatures.subtract([caller]) {
                description += "\n\t" + creature.name
            }
        }
        return description
    }
    
    // INTERACTIONS
    
    // Movement
    
    func enter(creatures: Creature) -> String { // called when an creatures enters a location
        self.creatures.insert(creatures)
        return self.description // give the description, in case they want to display it (players will use it)
    }
    
    func exit(creatures: Creature) {
        self.creatures.remove(creatures)
    }
    
    func go(direction: String, by caller: Creature) {
        if let portal = directions[direction]! { // can go that way
            portal.traverse(caller, from: self)
        } else { // can't go that way
            message("you can't go that way!")
        }
    }
    
    // Items
    
    func insert(items: Set<Item>) {
        self.contents.unionInPlace(items)
    }
    
    func extract(items: Set<Item>) {
        self.contents.subtractInPlace(items)
    }
    
}