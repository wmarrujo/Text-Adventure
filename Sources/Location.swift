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
    
    func findItemsWithSelector(selector: (Item) -> Bool) -> Set<Item> {
        var items: Set<Item> = []
        for item in self.contents {
            if selector(item) { // if item matches rule
                items.insert(item)
            }
        }
        return items
    }
    
    override func showDescription() -> String {
        var description = self.description
        if !self.contents.isEmpty {
            description += "\n You see around you:"
            for item in self.contents {
                description += "\n\t" + item.description
            }
        }
        if !self.creatures.isEmpty {
            description += "\n here with you is:"
            for creatures in self.creatures {
                description += "\n\t" + creatures.description
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
    
    func insert(item: Item) {
        self.contents.insert(item)
    }
    
    func extract(item: Item) {
        self.contents.remove(item)
    }
    
}