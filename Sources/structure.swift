class PhrasalCategory: Hashable {
    var hashValue: Int { // To conform with Hashable
        return unsafeAddressOf(self).hashValue
    }
    
    var categoryType: String
    
    init() {
        self.categoryType = ""
    }
}

func ==(lhs: PhrasalCategory, rhs: PhrasalCategory) -> Bool {
  return lhs.hashValue == rhs.hashValue
}

class LexicalCategory: PhrasalCategory {
    let word: String
    
    init(_ word: String) {
        self.word = word
        super.init()
    }
}

////////////////////////////////////////////////////////////////
// LEXICAL CATEGORIES
////////////////////////////////////////////////////////////////

class Verb: LexicalCategory { // Performs Specific Action
    override init(_ word: String) {
        super.init(word)
        self.categoryType = "V"
    }
}

class Noun: LexicalCategory { // Refers to Items
    override init(_ word: String) {
        super.init(word)
        self.categoryType = "N"
    }
}

class Adjective: LexicalCategory { // An Item Filter by Attribute
    override init(_ word: String) {
        super.init(word)
        self.categoryType = "A"
    }
}

class Adverb: LexicalCategory { // An Action Modifier (argument)
    override init(_ word: String) {
        super.init(word)
        self.categoryType = "B"
    }
}

class Preposition: LexicalCategory { // An Item Filter by Relation
    override init(_ word: String) {
        super.init(word)
        self.categoryType = "P"
    }
}

class Conjunction: LexicalCategory { // A Constructor for Compound Clauses
    override init(_ word: String) {
        super.init(word)
        self.categoryType = "C"
    }
}

class Determiner: LexicalCategory { // Specifies by Quantity or a Default // TODO: not sure on this one
    override init(_ word: String) {
        super.init(word)
        self.categoryType = "D"
    }
}

////////////////////////////////////////////////////////////////
// PHRASAL CATEGORIES
////////////////////////////////////////////////////////////////

class NounPhrase: PhrasalCategory { // Selects Items
    let determiner: Determiner?
    let adjective: Adjective?
    let noun: Noun?
    let prepositionalPhrase: PrepositionalPhrase?
    
    let firstNounPhrase: NounPhrase?
    let conjunction: Conjunction?
    let secondNounPhrase: NounPhrase?
    
    let conjunctiveState: Bool
    
    // INITIALIZERS
    init(withDeterminer determiner: Determiner? = nil, withAdjective adjective: Adjective? = nil, withNoun noun: Noun, withPrepositionalPhrase prepositionalPhrase: PrepositionalPhrase? = nil) {
        self.determiner = determiner
        self.adjective = adjective
        self.noun = noun
        self.prepositionalPhrase = prepositionalPhrase
        self.conjunctiveState = false
        
        self.firstNounPhrase = nil
        self.conjunction = nil
        self.secondNounPhrase = nil
        
        super.init()
        self.categoryType = "NP"
    }
    
    init(withNounPhrase firstNounPhrase: NounPhrase, conjunction: Conjunction, andSecondNounPhrase secondNounPhrase: NounPhrase) {
        self.firstNounPhrase = firstNounPhrase
        self.conjunction = conjunction
        self.secondNounPhrase = secondNounPhrase
        self.conjunctiveState = true
        
        self.determiner = nil
        self.adjective = nil
        self.noun = nil
        self.prepositionalPhrase = nil
        
        super.init()
        self.categoryType = "NP"
    }
    
    // METHODS
    func nounPhraseByRemovingPrepositionalPhrase() -> NounPhrase {
        if self.conjunctiveState {
            return NounPhrase(withDeterminer: self.determiner, withAdjective: self.adjective!, withNoun: self.noun!)
        } else {
            return self
        }
    }
}

class PrepositionalPhrase: PhrasalCategory { // Filters Items
    let preposition: Preposition?
    let nounPhrase: NounPhrase?
    let firstPrepositionalPhrase: PrepositionalPhrase?
    let conjunction: Conjunction?
    let secondPrepositionalPhrase: PrepositionalPhrase?
    let conjunctiveState: Bool
    
    // INITIALIZERS
    init(withPreposition preposition: Preposition, withNounPhrase nounPhrase: NounPhrase? = nil) {
        self.preposition = preposition
        self.nounPhrase = nounPhrase
        self.conjunctiveState = false
        
        self.firstPrepositionalPhrase = nil
        self.conjunction = nil
        self.secondPrepositionalPhrase = nil
        
        super.init()
        self.categoryType = "PP"
    }
    
    init(withPrepositionalPhrase firstPrepositionalPhrase: PrepositionalPhrase, conjunction: Conjunction, andSecondPrepositionalPhrase secondPrepositionalPhrase: PrepositionalPhrase) {
        self.firstPrepositionalPhrase = firstPrepositionalPhrase
        self.conjunction = conjunction
        self.secondPrepositionalPhrase = secondPrepositionalPhrase
        self.conjunctiveState = true
        
        self.preposition = nil
        self.nounPhrase = nil
        
        super.init()
        self.categoryType = "PP"
    }
    
    // METHODS
}

class VerbPhrase: PhrasalCategory { // Performs Action
    let verb: Verb?
    let nounPhrase: NounPhrase?
    let prepositionalPhrase: PrepositionalPhrase?
    let adverb: Adverb?
    let firstVerbPhrase: VerbPhrase?
    let conjunction: Conjunction?
    let secondVerbPhrase: VerbPhrase?
    let conjunctiveState: Bool
    
    // INITIALIZERS
    init(withVerb verb: Verb, withNounPhrase nounPhrase: NounPhrase? = nil, withPrepositionalPhrase prepositionalPhrase: PrepositionalPhrase? = nil, withAdverb adverb: Adverb?) {
        self.verb = verb
        self.nounPhrase = nounPhrase
        self.prepositionalPhrase = prepositionalPhrase
        self.adverb = adverb
        self.conjunctiveState = false
        
        self.firstVerbPhrase = nil
        self.conjunction = nil
        self.secondVerbPhrase = nil
        
        super.init()
        self.categoryType = "VP"
    }
    
    init(withVerbPhrase firstVerbPhrase: VerbPhrase, conjunction: Conjunction, andSecondVerbPhrase secondVerbPhrase: VerbPhrase) {
        self.firstVerbPhrase = firstVerbPhrase
        self.conjunction = conjunction
        self.secondVerbPhrase = secondVerbPhrase
        self.conjunctiveState = true
        
        self.verb = nil
        self.nounPhrase = nil
        self.prepositionalPhrase = nil
        self.adverb = nil
        
        super.init()
        self.categoryType = "VP"
    }
    
    // METHODS
    func perform() {
        if conjunctiveState { // if it's a conjunction
            // firstVerbPhrase.perform()
            // secondVerbPhrase.perform()
        } else { // if it's a regular Verb Phrase
            // Player.perform(nounPhrase, etc.)
        }
    }
}