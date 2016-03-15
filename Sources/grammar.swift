////////////////////////////////////////////////////////////////
// STRUCTURE
////////////////////////////////////////////////////////////////

struct Rule {
    let components: [String]
    let result: String
    
    // INITIALIZERS
    init(withComponents components: [String], toResult result: String) {
        self.components = components
        self.result = result
    }
    
    init(_ rule: String) {
        if let range = rule.rangeOfString(" -> ") {
            self.components = rule.substringToIndex(range.startIndex).componentsSeparatedByCharactersInSet(whitespace)
            self.result = rule.substringFromIndex(range.endIndex)
        } else {
            self.components = []
            self.result = ""
        }
    }
    
    // METHODS
    func matches(tokens: [Set<PhrasalCategory>]) -> Bool {
        if self.components.count == tokens.count { // if the lengths match
            for (index, component) in self.components.enumerate() {
                if !tokens[index].map({ $0.categoryType }).contains(component) { // if component can be of that category type
                    return false
                }
            }
            return true
        }
        return false
    }
    
    func buildPhrase(tokens: [Set<PhrasalCategory>]) -> PhrasalCategory? {
        // expects the tokens coming in to have already passed self.matches
        
        // use a specific initializer
        switch(self.result) {
            case "A": break
                
            case "B": break
                
            case "C": break // no such case
            case "D": break // no such case
            case "N": break // no such case
            case "P": break // no such case
            case "V": break // no such case
            case "NP":
                print("return type of rule is NP")
                if self.components.contains("C") { // then use the conjunction initializer
                    /*print("self.components.contains(\"C\")")
                    
                    // setup parameters
                    var firstNounPhrase: NounPhrase? = nil
                    var conjunction: Conjunction? = nil
                    var secondNounPhrase: NounPhrase? = nil
                    
                    // associate parameters
                    var parameterIndex = 0
                    let parameters = ["NP", "C", "NP"]
                    
                    for tokenPhrases in tokens {
                        var match = false
                        while !match {
                            if tokenPhrases.map({ $0.categoryType }).contains(paramters[parameterIndex]) {
                                match = true
                                
                                switch parameterIndex {
                                    case 0: firstNounPhrase = tokenPhrases.filter({ $0 is NounPhrase}).first as? NounPhrase
                                    case 1: conjunction = tokenPhrases.filter({ $0 is Conjunction}).first as? Conjunction
                                    case 2: secondNounPhrase = tokenPhrases.filter({ $0 is NounPhrase}).first as? NounPhrase
                                    default: message("could not match parameter to correct type")
                                }
                            } else {
                                parameterIndex = parameterIndex + 1
                            }
                        }
                    }
                    
                    // apply parameters
                    return NounPhrase(withNounPhrase: firstNounPhrase, conjunction: conjunction, andSecondNounPhrase: secondNounPhrase)*/
                } else { // then use a regular initializer
                    // TODO: begin here: write this type of initializer preparation for all the other initializers we'll be using
                    print("self.components does not contain C")
                    
                    // setup parameters
                    var determiner: Determiner? = nil
                    var adjective: Adjective? = nil
                    var noun: Noun? = nil // FIXME: unsafe as optional
                    var prepositionalPhrase: PrepositionalPhrase? = nil
                    
                    // associate parameters
                    var parameterIndex = 0
                    let parameters = ["D", "A", "N", "PP"]
                    
                    for tokenPhrases in tokens { // for each token in the subphrase "tokens" match it to a type // tokenPhrases is the [Set<PhrasalCategory>]
                        print("tokenPhrases: \(tokenPhrases)")
                        print("mapped: \(tokenPhrases.map({ $0.categoryType }))")
                        
                        var match = false
                        while !match { // test it for each of the phrasal categories in the constructor in sequence
                            print("match: \(tokenPhrases.map({ $0.categoryType }).contains(parameters[parameterIndex]))")
                            if tokenPhrases.map({ $0.categoryType }).contains(parameters[parameterIndex]) { // token can be of type that the parameter needs
                                print("tokenPhrases contains type in parameter list")
                                match = true
                                // set the parameter to that value of that token
                                
                                switch parameterIndex {
                                    case 0: determiner = tokenPhrases.filter({ $0 is Determiner }).first as? Determiner
                                    case 1: adjective = tokenPhrases.filter({ $0 is Adjective }).first as? Adjective
                                    case 2: noun = tokenPhrases.filter({ $0 is Noun }).first as? Noun
                                    case 3: prepositionalPhrase = tokenPhrases.filter({ $0 is PrepositionalPhrase }).first as? PrepositionalPhrase
                                    default: message("could not match parameter to correct type") // TODO: better error message
                                }
                            } else { // token cannot be what parameter needs
                                parameterIndex = parameterIndex + 1 // increment to try the next parameter  // (only increase, don't reset, to preserve order of rule)
                            }
                        }
                    }
                    
                    print("")
                    
                    print("determiner: \(determiner)")
                    print("adjective: \(adjective)")
                    print("noun: \(noun)")
                    print("prepositionalPhrase: \(prepositionalPhrase)")
                    // apply parameters
                    return NounPhrase(withDeterminer: determiner, withAdjective: adjective, withNoun: noun!, withPrepositionalPhrase: prepositionalPhrase)
                }
            case "PP":
                if self.components.contains("C") { // then use the conjunction initializer
                    
                } else { // then use a regular initializer
                    
                }
            case "VP":
                if self.components.contains("C") { // then use the conjunction initializer
                    
                } else { // then use a regular initializer
                    
                }
            default:
                message("failed in building a phrase from these tokens: \(dump(tokens))") // TODO: give a better error message
        }
        
        return nil
    }
}

////////////////////////////////////////////////////////////////
// GRAMMAR
////////////////////////////////////////////////////////////////

// N = Noun
// NP = Noun Phrase
// P = Preposition
// PP = Prepositional Phrase
// V = Verb
// VP = Verb Phrase
// A = Adjective
// B = Adverb
// C = Conjunction
// D = Determiner

// NOTE: this essentially gets used in pattern matching, so
// NOTE: pattern matching rules apply. As in, write the rules
// NOTE: backwards so that it matches the most complex first,
// NOTE: then the least complex only if it isn't able to form a
// NOTE: more complex structure

let grammar = [ // Rules for turning individual arrays of phrasal categories into a single phrasal category
    // SINGLE-WORD PHRASES -------------------------------------
    
    // SINGLE-WORD CONNECTION
    "A C A -> A", // blue and big
    "A A -> A", // big blue
    "B C B -> B", // fast and quietly
    
    // FUNDAMENTAL NOUN PHRASE
    
    "D A N -> NP", // the large apple
    "A N -> NP", // large apple
    "D N -> NP", // the apple
    "N -> NP", // apple
    
    // FUNDAMENTAL PREPOSITION
    
    "P -> PP", // up // generally for use in compound phrases
    
    // FUNDAMENTAL VERB PHRASE
    
    "V B -> VP", // jump quickly | run fast
    "V -> VP", // jump
    
    // COMPOUND PHRASES ----------------------------------------
    
    // CONNECTION PHRASES
    "NP C NP -> NP", // [the sword] and [the shield]
    "PP C PP -> PP", // east then west
    "VP C VP -> VP", // [eat bread] then [go west]
    
    // COMPOUND NOUN PHRASES
    "NP PP -> NP", // [the big apple] [in the park] // completes the "D A N PP -> NP" rule
    
    // COMPOUND PREPOSITIONAL PHRASES
    
    // COMPOUND VERB PHRASES
    "VP NP B -> VP", // climb rocks carefully
    "VP NP -> VP", // take apple
    "VP PP -> VP", // jump up | pick up
    "VP PP B -> VP", // run [west] sneakily
    "VP PP NP B -> VP", // take with tongs carefully
    "VP PP NP -> VP", // climb up trees | run down stairs
    "VP B PP NP -> VP" // take carefully with tongs
].map({ Rule($0) })