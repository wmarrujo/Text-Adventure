public class Player: Creature {
    
    ////////////////////////////////////////////////////////////////
    // INSTANCE VARIABLES
    ////////////////////////////////////////////////////////////////
    
    var playing: Bool = true // to quit game loop // always starts as true when created (obviously)
    
    ////////////////////////////////////////////////////////////////
    // INITIALIZATION
    ////////////////////////////////////////////////////////////////
    
    /*init(named name: String, andDescription description: String = "", withHealth health: Int, atLocation location: Location, withEncumbrence encumbrance: Int, withInventoryOf inventory: Set<Item> = []) {
        super.init(named: name, andDescription: description, withHealth: health, atLocation: location, withEncumbrence: encumbrance, withInventoryOf: inventory)
    }*/
    
    ////////////////////////////////////////////////////////////////
    // METHODS
    ////////////////////////////////////////////////////////////////
    
    // STATUS
    
    
    
    // INTERACTIONS
    
    func input() {
        parse(prompt("> "), player: self) // global prompt
    }
    
    func perform(command: RegularVerbPhrase) {
        switch command.verb.word {
            case "quit":
                if command.nounPhrase == nil && command.prepositionalPhrase == nil && command.adverb == nil {
                    quitGame()
                } else {
                    message("quit failed")
                }
            case "go":
                self.go(command.prepositionalPhrase)
            default:
                message("unknown command given") // then the developer forgot to implement from the lexicon
        }
    }
    
    // ACTIONS
    
    func quitGame() {
        // TODO: make a quit sequence
        message("goodbye")
        self.playing = false
    }
    
    func take(selector: NounPhrase, modifier: Adverb?) { // transfer an item from the location to your inventory
        // selector guaranteed not to have a prepositional phrase
        message("took \(selector) \(modifier)")
    }
    
    func take(selector: NounPhrase, from target: NounPhrase, modifier: Adverb?) { // transfer an item from the target's inventory to your own
        message("took \(selector) from \(target) \(modifier)")
    }
    
    func give(selector: NounPhrase, to target: NounPhrase, modifier: Adverb?) { // transfer item from your inventory to another creature's inventory
        message("gave \(selector) to \(target) \(modifier)")
    }
    
    func drop(selector: NounPhrase, modifier: Adverb?) { // transfer item from your inventory to the location
        message("dropped \(selector) \(modifier)")
    }
    
    func `throw`(selector: NounPhrase, at target: NounPhrase, modifier: Adverb?) { // transfer object to location and do damage to target
        message("threw \(selector) at \(target) \(modifier)")
    }
    
    func go(direction: PrepositionalPhrase?) { // move from this location to another through a portal
        if direction == nil {
            message("please specify a direction")
            return // abort
        }
        
        if let dir = direction as? RegularPrepositionalPhrase {
            switch dir.preposition.word {
                case "up", "down", "north", "south", "east", "west", "in":
                    message("you went \(dir.preposition.word)")
                default:
                    message("your direction was not understood")
            }
        } else if let dir = direction as? CompoundPrepositionalPhrase { // direction is CompoundPrepositionalPhrase
            switch dir.conjunction.word {
                case "and":
                    message("you can't move two ways at once!")
                case "then":
                    self.go(dir.firstPrepositionalPhrase)
                    message("then")
                    self.go(dir.secondPrepositionalPhrase)
                default:
                    message("I do not understand that conjunction in this context")
            }
        }
    }
    
}