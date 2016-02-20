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
    "NP PP -> NP", // [the big apple] [in the park] | pick up
    
    // COMPOUND PREPOSITIONAL PHRASES
    "P NP -> PP", // in [the park]
    
    // COMPOUND VERB PHRASES
    "VP NP B -> VP", // climb rocks carefully
    "VP NP -> VP", // take [apple]
    "VP PP -> VP", // jump [up]
    "VP PP B -> VP", // run [west] sneakily
    "VP PP NP B -> VP", // take with tongs carefully
    "VP PP NP -> VP", // climb up trees | run down stairs
    "VP B PP NP -> VP" // take carefully with tongs
].map({ Rule($0) })