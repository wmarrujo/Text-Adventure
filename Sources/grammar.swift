////////////////////////////////////////////////////////////////
// STRUCTURE
////////////////////////////////////////////////////////////////

struct Rule {
    let components: [String]
    let result: String
    let constructor: [PhrasalCategory] -> PhrasalCategory
    
    // INITIALIZERS
    init(withComponents components: [String], toResult result: String, withAssociatedConstructor constructor: [PhrasalCategory] -> PhrasalCategory) {
        self.components = components
        self.result = result
        self.constructor = constructor
    }
    
    init(_ rule: String, constructor: [PhrasalCategory] -> PhrasalCategory) {
        if let range = rule.rangeOfString(" -> ") {
            self.components = rule.substringToIndex(range.startIndex).componentsSeparatedByCharactersInSet(whitespace)
            self.result = rule.substringFromIndex(range.endIndex)
            self.constructor = constructor
        } else {
            self.components = []
            self.result = ""
            self.constructor = constructor
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
    
    func buildPhrase(tokens: [Set<PhrasalCategory>]) throws -> PhrasalCategory {
        // PREPARE TOKENS TO BE ARGUMENTS TO THE CONSTRUCTOR
        
        let tokenPhrasesArguments = Array(Zip2Sequence(self.components, tokens))
        let argumentArray = try tokenPhrasesArguments.map({
            (phrasalCategory: String, tokenPhrases: Set<PhrasalCategory>) -> PhrasalCategory in // apply to each token
            
            for tokenPhrase in tokenPhrases { // test each phrasal category possibility for the given token
                if tokenPhrase.categoryType == phrasalCategory { // if this phrasal category is the one specified in the rules
                    return tokenPhrase // select this phrasalCagegory
                }
            }
            
            // if it hasn't returned yet
            throw GrammarError.FailedInBuildingPhrase(phrase: tokens)
        })
        
        // APPLY ARGUMENTS TO CONSTRUCTOR
        
        return self.constructor(argumentArray)
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

let grammar = [ // Rules for turning individual arrays of phrasal categories into a single phrasal category
    // SINGLE-WORD PHRASES -------------------------------------
    
    // SINGLE-WORD CONNECTION
    ("A C A -> A", constructor: { CompoundAdjective(withAdjective: ($0[0] as! Adjective), conjunction: ($0[1] as! Conjunction), andAdjective: ($0[2] as! Adjective)) }), // blue and big
    ("A A -> A", constructor: { CompoundAdjective(withAdjective: ($0[0] as! Adjective), andAdjective: ($0[1] as! Adjective)) }), // big blue
    ("B C B -> B", constructor: { CompoundAdverb(withAdverb: ($0[0] as! Adverb), conjunction: ($0[1] as! Conjunction), andAdverb: ($0[2] as! Adverb)) }), // fast and quietly
    
    // FUNDAMENTAL NOUN PHRASE
    
    ("D A N -> NP", constructor: { RegularNounPhrase(withDeterminer: ($0[0] as! Determiner), withAdjective: ($0[1] as! Adjective), withNoun: ($0[2] as! Noun)) }), // the large apple
    ("A N -> NP", constructor: { RegularNounPhrase(withAdjective: ($0[0] as! Adjective), withNoun: ($0[1] as! Noun)) }), // large apple
    ("D N -> NP", constructor: { RegularNounPhrase(withDeterminer: ($0[0] as! Determiner), withNoun: ($0[1] as! Noun)) }), // the apple
    ("N -> NP", constructor: { RegularNounPhrase(withNoun: ($0[0] as! Noun)) }), // apple
    
    // FUNDAMENTAL PREPOSITION
    
    ("P -> PP", constructor: { RegularPrepositionalPhrase(withPreposition: ($0[0] as! Preposition)) }), // up // generally for use in compound phrases
    
    // FUNDAMENTAL VERB PHRASE
    
    ("V B -> VP", constructor: { RegularVerbPhrase(withVerb: ($0[0] as! Verb), withAdverb: ($0[1] as! Adverb)) }), // jump quickly | run fast
    ("V -> VP", constructor: { RegularVerbPhrase(withVerb: ($0[0] as! Verb)) }), // jump
    
    // COMPOUND PHRASES ----------------------------------------
    
    // CONNECTION PHRASES
    ("NP C NP -> NP", constructor: { CompoundNounPhrase(withNounPhrase: ($0[0] as! NounPhrase), conjunction: ($0[1] as! Conjunction), andNounPhrase: ($0[2] as! NounPhrase)) }), // [the sword] and [the shield]
    ("PP C PP -> PP", constructor: { CompoundPrepositionalPhrase(withPrepositionalPhrase: ($0[0] as! PrepositionalPhrase), conjunction: ($0[1] as! Conjunction), andPrepositionalPhrase: ($0[2] as! PrepositionalPhrase)) }), // east then west
    ("VP C VP -> VP", constructor: { CompoundVerbPhrase(withVerbPhrase: ($0[0] as! VerbPhrase), conjunction: ($0[1] as! Conjunction), andVerbPhrase: ($0[2] as! VerbPhrase)) }), // [eat bread] then [go west]
    
    // COMPOUND NOUN PHRASES
    ("D A N PP -> NP", constructor: { RegularNounPhrase(withDeterminer: ($0[0] as! Determiner), withAdjective: ($0[1] as! Adjective), withNoun: ($0[2] as! Noun), withPrepositionalPhrase: ($0[3] as! PrepositionalPhrase)) }), // [the big apple] [in the park] // completes the "D A N PP -> NP" rule
    
    // COMPOUND PREPOSITIONAL PHRASES
    ("P NP -> PP", constructor: { RegularPrepositionalPhrase(withPreposition: ($0[0] as! Preposition), withNounPhrase: ($0[1] as! NounPhrase)) }),
    
    // COMPOUND VERB PHRASES
    ("V NP B -> VP", constructor: { RegularVerbPhrase(withVerb: ($0[0] as! Verb), withNounPhrase: ($0[1] as! NounPhrase), withAdverb: ($0[2] as! Adverb)) }), // climb rocks carefully
    ("V NP -> VP", constructor: { RegularVerbPhrase(withVerb: ($0[0] as! Verb), withNounPhrase: ($0[1] as! NounPhrase)) }), // take apple
    ("V PP -> VP", constructor: { RegularVerbPhrase(withVerb: ($0[0] as! Verb), withPrepositionalPhrase: ($0[1] as! PrepositionalPhrase)) }), // jump up | pick up
    ("V PP B -> VP", constructor: { RegularVerbPhrase(withVerb: ($0[0] as! Verb), withPrepositionalPhrase: ($0[1] as! PrepositionalPhrase), withAdverb: ($0[2] as! Adverb)) }), // run [west] sneakily
    ("V PP NP B -> VP", constructor: { RegularVerbPhrase(withVerb: ($0[0] as! Verb), withPrepositionalPhrase: ($0[1] as! PrepositionalPhrase), withNounPhrase: ($0[2] as! NounPhrase), withAdverb: ($0[3] as! Adverb)) }), // take with tongs carefully
    ("V PP NP -> VP", constructor: { RegularVerbPhrase(withVerb: ($0[0] as! Verb), withPrepositionalPhrase: ($0[1] as! PrepositionalPhrase), withNounPhrase: ($0[2] as! NounPhrase)) }), // climb up trees | run down stairs
    ("V B PP NP -> VP", constructor: { RegularVerbPhrase(withVerb: ($0[0] as! Verb), withAdverb: ($0[1] as! Adverb), withPrepositionalPhrase: ($0[2] as! PrepositionalPhrase), withNounPhrase: ($0[3] as! NounPhrase)) }) // take carefully with tongs
    
].map({ // Turn each string and constructor pair into a grammar "Rule" object
    (arguments: (String, constructor: ([PhrasalCategory]) -> PhrasalCategory)) -> Rule in
    Rule(arguments)
})
