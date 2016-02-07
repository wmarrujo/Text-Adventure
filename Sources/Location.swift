public class Location: Thing {
    
    ////////////////////////////////////////////////////////////////
    // INSTANCE VARIABLES
    ////////////////////////////////////////////////////////////////
    
    var creature: Set<Creature>
    var contents: Set<Item>
    var directions: [String:Portal?]
    
    ////////////////////////////////////////////////////////////////
    // INITIALIZATION
    ////////////////////////////////////////////////////////////////
    
    init(named name: String, withDescription description: String = "", withCreature creature: Set<Creature> = [], withContents contents: Set<Item> = [], withUpExit up: Portal? = nil, withDownExit down: Portal? = nil, withNorthExit north: Portal? = nil, withSouthExit south: Portal? = nil, withEastExit east: Portal? = nil, withWestExit west: Portal? = nil) {
        self.creature = creature
        self.contents = contents
        self.directions = ["up":up, "down":down, "north":north, "south":south, "east":east, "west":west]
        super.init(name, description)
    }
    
    ////////////////////////////////////////////////////////////////
    // METHODS
    ////////////////////////////////////////////////////////////////
    
    // STATUS
    
    func findItemsWithRule(rule: (Item) -> Bool) -> Set<Item> {
        var items: Set<Item> = []
        for item in self.contents {
            if rule(item) { // if item matches rule
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
                description += "\n\t" + item.showDescription()
            }
        }
        if !self.creature.isEmpty {
            description += "\n here with you is:"
            for creature in self.creature {
                description += "\n\t" + creature.showDescription()
            }
        }
        return description
    }
    
    // INTERACTIONS
    
    func perform(command: String, toItems items: Set<Item>) {
        /*switch command {
            case "?":
                
            default:
                message("I don't know how to do that")
        }*/
    }
    
    // ACTIONS
    
    // Movement
    
    func enter(creature: Creature) { // called when an creature enters a location
        self.creature.insert(creature)
    }
    
    func go(direction: String, by caller: Creature) {
        if let portal = directions[direction]! { // can go that way
            // TODO: call exit from this location
            portal.traverse(caller, from: self)
        } else { // can't go that way
            message("you can't go that way")
        }
    }
    
}