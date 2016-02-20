class PhrasalCategory: Hashable {
    var hashValue: Int { // To conform with Hashable
        return unsafeAddressOf(self).hashValue
    }
}

func ==(lhs: PhrasalCategory, rhs: PhrasalCategory) -> Bool {
  return lhs.hashValue == rhs.hashValue
}

class LexicalCategory: PhrasalCategory {
    let word: String
    
    init(_ word: String) {
        self.word = word
    }
}

////////////////////////////////////////////////////////////////
// LEXICAL CATEGORIES
////////////////////////////////////////////////////////////////

class Verb: LexicalCategory { // Performs Specific Action
    
}

class Noun: LexicalCategory { // Refers to Items
    
}

class Adjective: LexicalCategory { // An Item Filter by Attribute
    
}

class Adverb: LexicalCategory { // An Action Modifier (argument)
    
}

class Preposition: LexicalCategory { // An Item Filter by Relation
    
}

class Conjunction: LexicalCategory { // A Constructor for Compound Clauses
    
}

class Determiner: LexicalCategory { // Specifies by Quantity or a Default // TODO: not sure on this one
    
}

////////////////////////////////////////////////////////////////
// PHRASAL CATEGORIES
////////////////////////////////////////////////////////////////

class NounPhrase: PhrasalCategory { // Selects Items
    let determiner: Determiner?
    let adjectives: Set<Adjective>?
    let noun: Noun?
    let prepositionalPhrase: PrepositionalPhrase?
    
    let firstNounPhrase: NounPhrase?
    let conjunction: Conjunction?
    let secondNounPhrase: NounPhrase?
    
    let conjunctiveState: Bool
    
    // INITIALIZERS
    init(withDeterminer determiner: Determiner? = nil, withAdjectives adjectives: Set<Adjective> = [], withNoun noun: Noun, withPrepositionalPhrase prepositionalPhrase: PrepositionalPhrase? = nil) {
        self.determiner = determiner
        self.adjectives = adjectives
        self.noun = noun
        self.prepositionalPhrase = prepositionalPhrase
        self.conjunctiveState = false
        
        self.firstNounPhrase = nil
        self.conjunction = nil
        self.secondNounPhrase = nil
    }
    
    init(withNounPhrase firstNounPhrase: NounPhrase, conjunction: Conjunction, andSecondNounPhrase secondNounPhrase: NounPhrase) {
        self.firstNounPhrase = firstNounPhrase
        self.conjunction = conjunction
        self.secondNounPhrase = secondNounPhrase
        self.conjunctiveState = true
        
        self.determiner = nil
        self.adjectives = nil
        self.noun = nil
        self.prepositionalPhrase = nil
    }
    
    // METHODS
    func nounPhraseByRemovingPrepositionalPhrase() -> NounPhrase {
        if self.conjunctiveState {
            return NounPhrase(withDeterminer: self.determiner, withAdjectives: self.adjectives!, withNoun: self.noun!)
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
    }
    
    init(withPrepositionalPhrase firstPrepositionalPhrase: PrepositionalPhrase, conjunction: Conjunction, andSecondPrepositionalPhrase secondPrepositionalPhrase: PrepositionalPhrase) {
        self.firstPrepositionalPhrase = firstPrepositionalPhrase
        self.conjunction = conjunction
        self.secondPrepositionalPhrase = secondPrepositionalPhrase
        self.conjunctiveState = true
        
        self.preposition = nil
        self.nounPhrase = nil
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