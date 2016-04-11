public class Location: Thing {
    
    ////////////////////////////////////////////////////////////////
    // INSTANCE VARIABLES
    ////////////////////////////////////////////////////////////////
    
    var creatures: Set<Creature>
    var contents: Set<Item>
    var directions: [String:Portal?]
    
    ////////////////////////////////////////////////////////////////
    // INITIALIZATION
    ////////////////////////////////////////////////////////////////
    
    init(named name: String, withDescription description: String = "", withCreature creatures: Set<Creature> = [], withContents contents: Set<Item> = [], withUpExit up: Portal? = nil, withDownExit down: Portal? = nil, withNorthExit north: Portal? = nil, withSouthExit south: Portal? = nil, withEastExit east: Portal? = nil, withWestExit west: Portal? = nil, withNorthwestExit northwest: Portal? = nil, withNortheastExit northeast: Portal? = nil, withSouthwestExit southwest: Portal? = nil, withSoutheastExit southeast: Portal? = nil) {
        self.creatures = creatures
        self.contents = contents
        self.directions = ["up":up, "down":down, "north":north, "south":south, "east":east, "west":west, "northwest":northwest, "northeast":northeast, "southwest":southwest, "southeast":southeast]
        super.init(name, description)
    }
    
    ////////////////////////////////////////////////////////////////
    // METHODS
    ////////////////////////////////////////////////////////////////
    
    // STATUS
    
    func showDescription(caller: Player) -> String {
        var description = self.description
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
    
    func enter(creatures: Creature) { // called when an creatures enters a location
        self.creatures.insert(creatures)
        if creatures is Player {
            (creatures as! Player).output(self.description)
        }
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