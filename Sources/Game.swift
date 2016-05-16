import Foundation
import SwiftyJSON

public class Game {
    
    // This class is the single connection between the user and the game world
    // it manages the player that the user represents
    // it manages all interaction with the user and their representational player
    // it manages the network interaction between this game instance and parallel ones for different clients when playing multiplayer
    // it manages the game loop
    // it manages the multithreading
    
    ////////////////////////////////////////////////////////////////
    // INSTANCE VARIABLES
    ////////////////////////////////////////////////////////////////
    
    var host: Player!
    var user: Player!
    
    var things: Set<Thing>
    
    var playing: Bool
    
    // World
    
    var startingLocationIDs: [Int]
    
    var startingLocations: [Location] {
        get {
            var locations: [Location] = []
            
            for id in self.startingLocationIDs {
                locations.append(self.getThingByID(id) as! Location)
            }
            
            return locations
        }
        set {
            var ids: [Int] = []
            
            for location in newValue {
                ids.append(location.id)
            }
            
            self.startingLocationIDs = ids
        }
    }
    
    ////////////////////////////////////////////////////////////////
    // INITIALIZATION
    ////////////////////////////////////////////////////////////////
    
    init(withJSON json: JSON, andUserWithName username: String, andDescription description: String = "") { // initialize a default game, with you as the user and the host
        // SET UP INSTANCE VARIABLES TO MAKE SELF AVAILABLE
        
        self.startingLocationIDs = []
        self.things = []
        self.playing = false
        self.user = nil
        self.host = nil
        
        // AFTER SELF IS AVAILABLE
        
        self.overwrite(withJSON: json, asUserWithName: username)
    }
    
    ////////////////////////////////////////////////////////////////
    // ARCHIVING
    ////////////////////////////////////////////////////////////////
    
    // ENCODE OBJECT TO JSON
    
    func toJSON() -> JSON {
        var json: JSON = [:]
        
        json["starting locations"] = JSON(self.startingLocationIDs)
        
        var things: [JSON] = []
        for thing in self.things {
            things.append(thing.toJSON())
        }
        json["things"] = JSON(things)
        
        return json
    }
    
    // DECODE OBJECT FROM JSON
    
    func overwrite(withJSON json: JSON, asUserWithName username: String, withHost hostname: String = "") { // if no hostname specified, use username by default
        let things: [JSON] = json["things"].arrayValue
        let startingLocations: [Int] = json["starting locations"].arrayValue.map({ $0.intValue })
        
        // TODO: Validate against json, load default if does not match minimum required for a game
        // TODO: test if starting locations has at least 1 id, and if that id matches a location in things
        
        // Reset Values
        
        self.startingLocationIDs = startingLocations
        self.things = []
        self.playing = false
        self.user = nil
        self.host = nil
        
        // Load things in world
        
        for thingJSON in things {
            switch thingJSON["type"].stringValue {
                case "Thing":
                    self.addThing(Thing(inGame: self, fromJSON: thingJSON))
                case "Location":
                    self.addThing(Location(inGame: self, fromJSON: thingJSON))
                case "Portal":
                    self.addThing(Portal(inGame: self, fromJSON: thingJSON))
                case "Creature":
                    self.addThing(Creature(inGame: self, fromJSON: thingJSON))
                case "Player":
                    self.addThing(Player(inGame: self, fromJSON: thingJSON))
                case "Item":
                    self.addThing(Item(inGame: self, fromJSON: thingJSON))
                case "Container":
                    self.addThing(Container(inGame: self, fromJSON: thingJSON))
                default:
                    break
            }
        }
        
        // Load Player
        
        // find player with username
        var user: Player! = nil
        var host: Player! = nil
        
        for player in self.things.filter({ $0 is Player }) { // for only all players
            if player.name == username {
                user = player as! Player // load self.user into that one
            }
            if player.name == hostname {
                host = player as! Player
            }
        }
        
        if user == nil { // if no user with that username
            user = Player(inGame: self, named: username, withDescription: "oh, look. this person hasn't yet updated their description.", withHealth: 100, atLocation: startingLocations[Int.random(0..<startingLocations.count)], withEncumbrance: 20) // create new user
            self.addThing(user!)
        }
        if host == nil { // if no host specified
            host = user! // choose user to be host by default
        }
        
        self.user = user
        self.host = host
    }
    
    ////////////////////////////////////////////////////////////////
    // METHODS
    ////////////////////////////////////////////////////////////////
    
    func begin() {
        self.playing = true
        
        self.output(self.user.location.showDescription(self.user))
        
        while self.playing {
            gameLoop()
        }
    }
    
    func end() {
        self.playing = false
    }
    
    func gameLoop() {
        self.input()
    }
    
    // WORLD
    
    func addThing(thing: Thing) {
        self.things.insert(thing)
    }
    
    func getThingByID(id: Int? = nil) -> Thing? {
        if id != nil {
            for t in self.things {
                if t.id == id {
                    return t
                }
            }
        }
        // if id == nil or didn't find match
        return nil
    }
    
    func nextID() -> Int {
        if let max = self.things.map({ $0.id }).maxElement() {
            return max + 1
        }
        return 0
    }
    
    // USER INTERACTION
    
    func input() {
        do {
            
            let command = try parse(prompt("> ")) // global prompt
            command.perform(self)
            
        } catch SyntaxError.NoMatchesInLexicon(let word) {
            self.output("I do not know what you mean by \"\(word)\". Perhaps you misspelled the word?")
            // TODO: maybe do some searching for words that are close?
        } catch SyntaxError.ForgotEndQuotation(let string) {
            self.output("You seemed to have forgotten to close your quotation somewhere in:\n\t\(string)")
        } catch GrammarError.TooManyTokensLeft(let tokens) { // cannot match grammar fully
            // the
            func formatTokens(tokens: [Set<PhrasalCategory>]) -> String {
                let phrases: [String] = tokens.map({ (phrasePossibilities: Set<PhrasalCategory>) -> String in
                    var possibilities: [String] = []
                    for item in phrasePossibilities { // phrasalCategories in the set
                        possibilities += [item.phrasalOutput]
                    }
                    return possibilities.joinWithSeparator("/")
                })
                return phrases.joinWithSeparator(" | ")
            }
            
            self.output("cannot infer what you mean by \"\(formatTokens(tokens))\"")
        } catch GrammarError.NoTokensInSentence {
            self.output("\(self.user.name) simply stood there. silent.")
        } catch GrammarError.MultipleBuildsPossible(let possibilities) { // ambiguous
            // the resulting set of phrasal categories has too many possibilites in it
            let builds: [String] = Array(possibilities).map({ (phrase: PhrasalCategory) -> String in
                phrase.phrasalOutput
            })
            
            self.output("Ambiguous usage of input. Did you mean: \"\(builds.joinWithSeparator("\" or \""))\"")
        } catch SemanticsError.NotACommand(let phrase) {
            self.output("please enter a command. \"\(phrase.phrasalOutput)\" phrase is not a command")
        } catch { // catch-all
            self.output("something went wrong in parsing your input, please try again")
        }
    }
    
    func output(text: String) {
        // NOTE: keep any output to the player going through this function
        message(text)
    }
    
    // _________________________
    // PhrasalCategory Reference
    //
    // NounPhrase <- (Determiner) (Adjective) Noun (PrepositionalPhrase)
    // PrepositionalPhrase <- Preposition (NounPhrase)
    // VerbPhrase <- Verb (NounPhrase) (PrepositionalPhrase) (Adverb)
    
    // The function that takes the command as a syntax tree and separates out the various data and applies them to the correct action function, or displays an appropriate error message
    func perform(command: RegularVerbPhrase) {
        switch command.verb.word {
            case "quit":
                if !hasNounPhrase(command) && !hasPrepositionalPhrase(command) && !hasAdverb(command) {
                    // TODO: check for save
                    quitGame()
                } else {
                    self.output("quit failed")
                }
            
            
            case "save":
                if hasNounPhrase(command) && !isCompound(command.np) && !hasPrepositionalPhrase(command) && !hasAdverb(command) {
                    // trim the leading and trailing quotations if it has them
                    var location = (command.np as! RegularNounPhrase).noun.word
                    if location.characters.first == "\"" && location.characters.last == "\"" { // the "noun" is surrounded by quotations (a.k.a. it's a string not a noun)
                        location = location.stringByTrimmingCharactersInSet(NSCharacterSet(charactersInString: "\"")) // trim the quotations
                        self.saveGame(to: location)
                    } else {
                        self.output("you tried to enter in a noun as a path! please wrap your location in parentheses")
                    }
                } else {
                    self.output("I don't understand how it is you want me to save\nThe syntax is:\n\tsave \"filename or full path\"")
                }
            
            
            case "load":
                if hasNounPhrase(command) && !isCompound(command.np) && !hasPrepositionalPhrase(command) && !hasAdverb(command) {
                    // trim the leading and trailing quotations if it has them
                    var location = (command.np as! RegularNounPhrase).noun.word
                    if location.characters.first == "\"" && location.characters.last == "\"" { // the "noun" is surrounded by quotations (a.k.a. it's a string not a noun)
                        location = location.stringByTrimmingCharactersInSet(NSCharacterSet(charactersInString: "\"")) // trim the quotations
                        self.loadGame(from: location)
                    } else {
                        self.output("you tried to enter in a noun as a path! please wrap your location in parentheses")
                    }
                } else {
                    self.output("I don't understand how it is you want me to load\nThe syntax is:\n\tsave \"filename or full path\"")
                }
            
            
            case "go":
                self.go(command.pp)
            
            
            case "look":
                if hasPrepositionalPhrase(command) && isCompound(command.pp) {
                    switch (command.pp as! RegularPrepositionalPhrase).prep.word {
                        case "at":
                            if hasNounPhrase(command) {
                                self.examine(command.np!, modifier: command.adv)
                            } else {
                                self.output("look at what?")
                            }
                        default:
                            self.output("look what?")
                    }
                } else if !hasNounPhrase(command) && !hasPrepositionalPhrase(command) && !hasAdverb(command) {
                    self.look()
                } else {
                    self.output("You're looking too complicatedly!")
                }
            
            
            case "examine":
                if hasNounPhrase(command) && !hasPrepositionalPhrase(command) {
                    self.examine(command.np!, modifier: command.adv)
                } else {
                    self.output("examine what?")
                }
            
            
            case "take":
                if hasPrepositionalPhrase(command) && !isCompound(command.pp) {
                    switch (command.pp as! RegularPrepositionalPhrase).prep.word {
                        case "from":
                            if hasNounPhrase(command) {
                                self.take(command.np!, modifier: command.adv)
                            } else {
                                self.output("take what from who?")
                            }
                        default:
                            self.output("take how?")
                    }
                } else {
                    if hasNounPhrase(command) {
                        self.take(command.np!, modifier: command.adv)
                    } else {
                        self.output("take what?")
                    }
                }
            
            
            case "say":
                if hasNounPhrase(command) && !hasPrepositionalPhrase(command) {
                    self.say((command.np as! RegularNounPhrase).n.word, modifier: command.adv)
                } else { // TODO: add support for target
                    self.output("say what?")
                }
            
            
            default:
                self.output("I don't know how to \(command.verb.word) yet") // then the developer forgot to implement from the lexicon
        }
    }
    
    // ACTIONS
    
    // Control
    
    func quitGame() {
        // TODO: make a quit sequence
        self.output("goodbye")
        self.end()
    }
    
    func saveGame(to location: String) {
        let gameString = self.toJSON().description
        
        do {
            if location.characters.first == "/" { // in absolute directory
                try save(gameString, to: location)
            } else { // in current directory
                try saveInCurrentDirectory(gameString, to: location)
            }
            
            self.output("saved successfully!")
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    func loadGame(from location: String) {
        do {
            let contents = try readInCurrentDirectory(location) // read string from file
            let jsonGame = JSON.parse(contents) // parse into json
            
            // FIXME: assuming you want to join this game using the same username as you chose in the beginning
            
            self.overwrite(withJSON: jsonGame, asUserWithName: self.user.name) // loading from a file, therefore, you are the user and host
            self.playing = true // continues game loop of prompts
            
        } catch let error as NSError {
            self.output(error.localizedDescription)
        }
    }
    
    // Interaction
    
    func take(selector: NounPhrase, from target: NounPhrase? = nil, modifier: Adverb?) { // transfer an item from the target's inventory to your own
        if (selector as! RegularNounPhrase).noun.word == "inventory" { // take inventory
            self.output(self.user.showInventory())
        } else { // take the item
            var items: Set<Item> = []
            do {
                if target == nil { // take from the location
                    items = try selector.select(fromItems: self.user.location.contents)
                } else { // take from the location specified
                    // TODO: add support for "take from [container]" && "take from [creature]" etc.
                    items = try selector.select(fromItems: self.user.location.contents)
                }
            } catch EvaluationError.DeterminerDidNotMatch(let determiner) {
                switch determiner {
                    case "the": // will be an error only if there are too many found and can't choose "the" item
                        self.output("matched too many")
                    case "a", "an": // only will be an error if it couldn't find any at all to choose from
                        self.output("no such items found")
                    default:
                        self.output("could not find items with restriction of \"\(determiner)\"")
                }
            } catch _ {
                self.output("unknown error when trying to find items")
            }
            
            if items.isEmpty {
                self.output("no such items found")
            } else { // it found things to take
                self.user.location.extract(items) // take the things from the location
                self.user.inventory.unionInPlace(items) // put them into your inventory
                self.output("taken")
                // TODO: test if it works
            }
        }
    }
    
    func give(selector: NounPhrase, to target: NounPhrase? = nil, modifier: Adverb?) { // transfer item from your inventory to another inventory
        
    }
    
    func look() {
        self.output(self.user.location.showDescription(self.user))
    }
    
    func examine(object: NounPhrase, modifier: Adverb? = nil) {
        for item in self.findItems(object) { // examine each item that matches filter
            item.showDescription()
            /* TODO: here
            switch modifier {
                case nil: // without modification
                    // do nothing
                case "closely":
                    // give very long details
                    // TODO: implement
                    
                default: // with unknown modification
                    self.output("examine \(object.phrasalOutput) how?")
            }*/
        }
    }
    
    func go(direction: PrepositionalPhrase?) { // move from this location to another through a portal
        if direction == nil {
            self.output("please specify a direction")
            return // abort
        }
        
        if let dir = direction as? RegularPrepositionalPhrase {
            switch dir.preposition.word {
                case "up", "down", "north", "south", "east", "west", "northwest", "northeast", "southwest", "southeast", "in", "out":
                    self.user.location.go(dir.preposition.word, by: self.user)
                default:
                    self.output("your direction was not understood")
            }
        } else if let dir = direction as? CompoundPrepositionalPhrase { // direction is CompoundPrepositionalPhrase
            switch dir.conjunction.word {
                case "and":
                    self.output("you can't move two ways at once!")
                case "then":
                    self.go(dir.firstPrepositionalPhrase)
                    self.output("then")
                    self.go(dir.secondPrepositionalPhrase)
                default:
                    self.output("I do not understand that conjunction in this context")
            }
        }
    }
    
    func say(phrase: String, to target: NounPhrase? = nil, modifier: Adverb?) {
        // TODO: say to however many people are in room
        // TODO: say loudly = yell to people in room and adjacent rooms
        // TODO: say softly = whisper = tell to a specific person, but notify others in room that you whispered/spoke to someone specific
        // TODO: say discreetly to a specific person & have a higher chance to not notify others in the room
        self.output(phrase)
    }
    
    // HELPERS
    
    func findItems(item: NounPhrase) -> Set<Item> {
        return []
    }
    
}

////////////////////////////////////////////////////////////////
// EXTERNAL DEPENDENCIES
////////////////////////////////////////////////////////////////
