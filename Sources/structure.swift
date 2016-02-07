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
    let adjectives: Set<Adjective>
    let noun: Noun
    let prepositionalPhrase: PrepositionalPhrase?
    
    init(withDeterminer determiner: Determiner? = nil, withAdjectives adjectives: Set<Adjective> = [], withNoun noun: Noun, withPrepositionalPhrase prepositionalPhrase: PrepositionalPhrase? = nil) {
        self.determiner = determiner
        self.adjectives = adjectives
        self.noun = noun
        self.prepositionalPhrase = prepositionalPhrase
    }
    
    func nounPhraseByRemovingPrepositionalPhrase() -> NounPhrase {
        return NounPhrase(withDeterminer: self.determiner, withAdjectives: self.adjectives, withNoun: self.noun)
    }
}

class PrepositionalPhrase: PhrasalCategory { // Filters Items
    let preposition: Preposition
    let nounPhrase: NounPhrase?
    
    init(withPreposition preposition: Preposition, withNounPhrase nounPhrase: NounPhrase? = nil) {
        self.preposition = preposition
        self.nounPhrase = nounPhrase
    }
}

class VerbPhrase: PhrasalCategory { // Performs Action
    let verb: Verb
    let nounPhrase: NounPhrase?
    let prepositionalPhrase: PrepositionalPhrase?
    let adverb: Adverb?
    
    init(withVerb verb: Verb, withNounPhrase nounPhrase: NounPhrase? = nil, withPrepositionalPhrase prepositionalPhrase: PrepositionalPhrase? = nil, withAdverb adverb: Adverb?) {
        self.verb = verb
        self.nounPhrase = nounPhrase
        self.prepositionalPhrase = prepositionalPhrase
        self.adverb = adverb
    }
}

// CONJUNCTION FORMS

class NounPhraseConjunction: PhrasalCategory {
    
}

class PrepositionalPhraseConjunction: PhrasalCategory {
    
}

class VerbPhraseConjunction: PhrasalCategory {
    
}