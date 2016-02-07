public class Player: Creature {
    
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
    // METHODS
    ////////////////////////////////////////////////////////////////
    
    // STATUS
    
    
    
    // INTERACTIONS
    
    func perform(command: String, selector: NounPhrase?, prepositionalPhrase: PrepositionalPhrase?, modifier: Adverb?) {
        switch command {
            case "take":
                if let nounPhrase = selector?.prepositionalPhrase?.nounPhrase { // has a prepositional phrase and the prepositional phrase has a noun phrase
                    switch selector!.prepositionalPhrase!.preposition.word {
                        case "from":
                            self.take(selector!.nounPhraseByRemovingPrepositionalPhrase(), from: nounPhrase, modifier: modifier)
                        default:
                            message("I don't know how to take \(selector!.prepositionalPhrase!.preposition.word) ...")
                    }
                } else if let nounPhrase = selector { // take [NP] // there is not a prepositional phrase
                    self.take(nounPhrase, modifier: modifier)
                } else { // take _ // there is only the verb
                    message("take what?")
                }
            case "give":
                if let nounPhrase = selector?.prepositionalPhrase?.nounPhrase { // there is a prepositional phrase
                    switch selector!.prepositionalPhrase!.preposition.word {
                        case "to": // give [NP] to [NP]
                            self.give(selector!, to: nounPhrase, modifier: modifier)
                        default:
                            message("I don't know how to give \(selector!.prepositionalPhrase!.preposition.word) ...")
                    }
                } else { // there is not a prepositional phrase
                    message("no target specified")
                }
            case "drop":
                if let nounPhrase = selector {
                    self.drop(nounPhrase, modifier: modifier)
                }
            case "throw":
                if let nounPhrase = selector?.prepositionalPhrase?.nounPhrase { // there is a prepositional phrase
                    switch selector!.prepositionalPhrase!.preposition.word {
                        case "at":
                            self.`throw`(selector!.nounPhraseByRemovingPrepositionalPhrase(), at: nounPhrase, modifier: modifier)
                        default:
                            message("I don't know how to throw \(selector!.prepositionalPhrase!.preposition.word) ...")
                    }
                } else { // there is not a prepositional phrase
                    message("no target specified")
                }
            case "go":
                if selector == nil && prepositionalPhrase != nil { // just a prepositional phrase
                    switch prepositionalPhrase!.preposition.word {
                        case "up", "down", "north", "south", "east", "west":
                            self.go(to: prepositionalPhrase!.preposition)
                        case "to":
                            message("please specify a direction")
                        default:
                            message("where is that")
                    }
                } else {
                    message("no direction specified or too many arguments")
                }
            default:
                message("I don't know how to do \(command)")
        }
    }
    
    // ACTIONS
    
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
    
    func go(to direction: Preposition) { // move from this location to another through a portal
        message("went \(direction)")
    }
    
}