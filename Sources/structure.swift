class PhrasalCategory: Hashable, CustomStringConvertible, OutputsPhrasally {
    var hashValue: Int { // To conform with Hashable
        return unsafeAddressOf(self).hashValue
    }
    
    var description: String {
        return "generic unknown phrasal category"
    }
    
    var phrasalOutput: String {
        return "_"
    }
    
    var categoryType: String
    
    init() {
        self.categoryType = ""
    }
}

func ==(lhs: PhrasalCategory, rhs: PhrasalCategory) -> Bool {
  return lhs.hashValue == rhs.hashValue
}

protocol OutputsPhrasally {
    var phrasalOutput: String { get }
}

class LexicalCategory: PhrasalCategory {
    let word: String
    
    override var phrasalOutput: String {
        return self.word
    }
    
    override var description: String {
        return "generic lexical category: " + self.word
    }
    
    init(_ word: String) {
        self.word = word
        super.init()
    }
}

////////////////////////////////////////////////////////////////
// LEXICAL CATEGORIES
////////////////////////////////////////////////////////////////

class Verb: LexicalCategory { // Performs Specific Action
    override var description: String {
        return "Verb: " + self.word
    }
    
    override init(_ word: String) {
        super.init(word)
        self.categoryType = "V"
    }
}

class Noun: LexicalCategory { // Refers to Items
    override var description: String {
        return "Noun: " + self.word
    }
    
    override init(_ word: String) {
        super.init(word)
        self.categoryType = "N"
    }
}

class Adjective: LexicalCategory { // An Item Filter by Attribute
    override var description: String {
        return "Adjective: " + self.word
    }
    
    override init(_ word: String) {
        super.init(word)
        self.categoryType = "A"
    }
}

class Adverb: LexicalCategory { // An Action Modifier (argument)
    override var description: String {
        return "Adverb: " + self.word
    }
    
    override init(_ word: String) {
        super.init(word)
        self.categoryType = "B"
    }
}

class Preposition: LexicalCategory { // An Item Filter by Relation
    override var description: String {
        return "Preposition: " + self.word
    }
    
    override init(_ word: String) {
        super.init(word)
        self.categoryType = "P"
    }
}

class Conjunction: LexicalCategory { // A Constructor for Compound Clauses
    override var description: String {
        return "Conjunction: " + self.word
    }
    
    override init(_ word: String) {
        super.init(word)
        self.categoryType = "C"
    }
}

class Determiner: LexicalCategory { // Specifies by Quantity or a Default // TODO: not sure on this one
    override var description: String {
        return "Determiner: " + self.word
    }
    
    override init(_ word: String) {
        super.init(word)
        self.categoryType = "D"
    }
}

////////////////////////////////////////////////////////////////
// PHRASAL CATEGORIES
////////////////////////////////////////////////////////////////

protocol NounPhrase: OutputsPhrasally {
    
}

class RegularNounPhrase: PhrasalCategory, NounPhrase { // Selects Items
    let determiner: Determiner?
    let adjective: Adjective?
    let noun: Noun
    let prepositionalPhrase: PrepositionalPhrase?
    
    override var description: String {
        return "Noun Phrase: \n    determiner: \(self.determiner)\n    adjective: \(self.adjective)\n    noun: \(self.noun)\n    prepositionalPhrase: { \(self.prepositionalPhrase) }"
    }
    
    override var phrasalOutput: String {
        var phrasalOutput = ""
        if let determiner = self.determiner?.phrasalOutput {
            phrasalOutput += " " + determiner
        }
        if let adjective = self.adjective?.phrasalOutput {
            phrasalOutput += " " + adjective
        }
        phrasalOutput += " " + self.noun.phrasalOutput
        if let prepositionalPhrase = self.prepositionalPhrase?.phrasalOutput {
            phrasalOutput += " [" + prepositionalPhrase + "]"
        }
        return phrasalOutput
    }
    
    // INITIALIZERS
    init(withDeterminer determiner: Determiner? = nil, withAdjective adjective: Adjective? = nil, withNoun noun: Noun, withPrepositionalPhrase prepositionalPhrase: PrepositionalPhrase? = nil) {
        self.determiner = determiner
        self.adjective = adjective
        self.noun = noun
        self.prepositionalPhrase = prepositionalPhrase
        
        super.init()
        self.categoryType = "NP"
    }
    
    // METHODS
    func regularNounPhraseByRemovingPrepositionalPhrase() -> RegularNounPhrase {
        return RegularNounPhrase(withDeterminer: self.determiner, withAdjective: self.adjective, withNoun: self.noun)
    }
}

class CompoundNounPhrase: PhrasalCategory, NounPhrase {
    let firstNounPhrase: NounPhrase
    let conjunction: Conjunction
    let secondNounPhrase: NounPhrase
    
    override var description: String {
        return "Noun Phrase (Compound): \n    first Noun Phrase: { \(self.firstNounPhrase) }\n    conjunction: \(self.conjunction)\n    second Noun Phrase: { \(self.secondNounPhrase) }"
    }
    
    override var phrasalOutput: String {
        var phrasalOutput = ""
        phrasalOutput += " [" + self.firstNounPhrase.phrasalOutput + "]"
        phrasalOutput += " " + self.conjunction.phrasalOutput
        phrasalOutput += " [" + self.secondNounPhrase.phrasalOutput + "]"
        return phrasalOutput
    }
    
    init(withNounPhrase firstNounPhrase: NounPhrase, conjunction: Conjunction, andNounPhrase secondNounPhrase: NounPhrase) {
        self.firstNounPhrase = firstNounPhrase
        self.conjunction = conjunction
        self.secondNounPhrase = secondNounPhrase
        
        super.init()
        self.categoryType = "NP"
    }
}

protocol PrepositionalPhrase: OutputsPhrasally {
    
}

class RegularPrepositionalPhrase: PhrasalCategory, PrepositionalPhrase { // Filters Items
    let preposition: Preposition
    let nounPhrase: NounPhrase?
    
    override var description: String {
        return "Prepositional Phrase: \n    preposition: \(self.preposition)\n    Noun Phrase: { \(self.nounPhrase) }"
    }
    
    override var phrasalOutput: String {
        var phrasalOutput = ""
        phrasalOutput += " " + self.preposition.phrasalOutput
        if let nounPhrase = self.nounPhrase?.phrasalOutput {
            phrasalOutput += " [" + nounPhrase + "]"
        }
        return phrasalOutput
    }
    
    // INITIALIZERS
    init(withPreposition preposition: Preposition, withNounPhrase nounPhrase: NounPhrase? = nil) {
        self.preposition = preposition
        self.nounPhrase = nounPhrase
        
        super.init()
        self.categoryType = "PP"
    }
    
    // METHODS
}

class CompoundPrepositionalPhrase: PhrasalCategory, PrepositionalPhrase {
    let firstPrepositionalPhrase: PrepositionalPhrase
    let conjunction: Conjunction
    let secondPrepositionalPhrase: PrepositionalPhrase
    
    override var description: String {
        return "Prepositional Phrase (Compound): \n    first Prepositional Phrase: { \(self.firstPrepositionalPhrase) }\n    conjunction: \(self.conjunction)\n    second Prepositional Phrase: { \(self.secondPrepositionalPhrase) }"
    }
    
    override var phrasalOutput: String {
        var phrasalOutput = ""
        phrasalOutput += " [" + self.firstPrepositionalPhrase.phrasalOutput + "]"
        phrasalOutput += " " + self.conjunction.phrasalOutput
        phrasalOutput += " [" + self.secondPrepositionalPhrase.phrasalOutput + "]"
        return phrasalOutput
    }
    
    init(withPrepositionalPhrase firstPrepositionalPhrase: PrepositionalPhrase, conjunction: Conjunction, andPrepositionalPhrase secondPrepositionalPhrase: PrepositionalPhrase) {
        self.firstPrepositionalPhrase = firstPrepositionalPhrase
        self.conjunction = conjunction
        self.secondPrepositionalPhrase = secondPrepositionalPhrase
        
        super.init()
        self.categoryType = "PP"
    }
}

protocol VerbPhrase: OutputsPhrasally {
    func perform(player: Player)
}

class RegularVerbPhrase: PhrasalCategory, VerbPhrase { // Performs Action
    let verb: Verb
    let nounPhrase: NounPhrase?
    let prepositionalPhrase: PrepositionalPhrase?
    let adverb: Adverb?
    
    override var description: String {
        return "Verb Phrase: \n    verb: \(self.verb)\n    Noun Phrase: { \(self.nounPhrase) }\n    Prepositional Phrase: { \(self.prepositionalPhrase) }\n    Adverb: \(self.adverb)"
    }
    
    override var phrasalOutput: String {
        var phrasalOutput = ""
        phrasalOutput += " " + self.verb.phrasalOutput
        if let nounPhrase = self.nounPhrase?.phrasalOutput {
            phrasalOutput += " [" + nounPhrase + "]"
        }
        if let prepositionalPhrase = self.prepositionalPhrase?.phrasalOutput {
            phrasalOutput += " [" + prepositionalPhrase + "]"
        }
        if let adverb = self.adverb?.phrasalOutput {
            phrasalOutput += " " + adverb
        }
        return phrasalOutput
    }
    
    // INITIALIZERS
    init(withVerb verb: Verb, withNounPhrase nounPhrase: NounPhrase? = nil, withPrepositionalPhrase prepositionalPhrase: PrepositionalPhrase? = nil, withAdverb adverb: Adverb? = nil) {
        self.verb = verb
        self.nounPhrase = nounPhrase
        self.prepositionalPhrase = prepositionalPhrase
        self.adverb = adverb
        
        super.init()
        self.categoryType = "VP"
    }
    
    // METHODS
    func perform(player: Player) {
        player.perform(self)
    }
}

class CompoundVerbPhrase: PhrasalCategory {
    let firstVerbPhrase: VerbPhrase
    let conjunction: Conjunction
    let secondVerbPhrase: VerbPhrase
    
    override var description: String {
        return "Verb Phrase (Compound): \n    first Verb Phrase: { \(self.firstVerbPhrase) }\n    conjunction: \(self.conjunction)\n    second Verb Phrase: { \(self.secondVerbPhrase) }"
    }
    
    override var phrasalOutput: String {
        var phrasalOutput = ""
        phrasalOutput += " [" + self.firstVerbPhrase.phrasalOutput + "]"
        phrasalOutput += " " + self.conjunction.phrasalOutput
        phrasalOutput += " [" + self.secondVerbPhrase.phrasalOutput + "]"
        return phrasalOutput
    }
    
    init(withVerbPhrase firstVerbPhrase: VerbPhrase, conjunction: Conjunction, andVerbPhrase secondVerbPhrase: VerbPhrase) {
        self.firstVerbPhrase = firstVerbPhrase
        self.conjunction = conjunction
        self.secondVerbPhrase = secondVerbPhrase
        
        super.init()
        self.categoryType = "VP"
    }
    
    // METHODS
    func perform(player: Player) {
        // TODO: maybe check for type of conjunction for "and" not "or" or something
        self.firstVerbPhrase.perform(player)
        self.secondVerbPhrase.perform(player)
    }
}

// COMPOUND PHRASAL CATEGORIES

class CompoundAdjective: Adjective {
    let firstAdjective: Adjective
    let secondAdjective: Adjective
    
    override var description: String {
        return "Adjective (Compound): { First Adjective: \(self.firstAdjective), Second Adjective: \(self.secondAdjective) }"
    }
    
    override var phrasalOutput: String {
        var phrasalOutput = ""
        phrasalOutput += " " + self.firstAdjective.phrasalOutput
        phrasalOutput += " " + self.secondAdjective.phrasalOutput
        return phrasalOutput
    }
    
    init(withAdjective firstAdjective: Adjective, conjunction: Conjunction, andAdjective secondAdjective: Adjective) {
        // TODO: handle conjunction here ("and" or "or" or "not" differences and negate second or first accordingly)
        self.firstAdjective = firstAdjective
        self.secondAdjective = secondAdjective
        
        super.init(self.firstAdjective.word + " " + self.secondAdjective.word)
    }
    
    init(withAdjective firstAdjective: Adjective, andAdjective secondAdjective: Adjective) {
        self.firstAdjective = firstAdjective
        self.secondAdjective = secondAdjective
        
        super.init(self.firstAdjective.word + " " + self.secondAdjective.word)
    }
}

class CompoundAdverb: Adverb {
    let firstAdverb: Adverb
    let secondAdverb: Adverb
    
    override var description: String {
        return "Adverb (Compound): { First Adverb: \(self.firstAdverb), Second Adverb: \(self.secondAdverb) }"
    }
    
    override var phrasalOutput: String {
        var phrasalOutput = ""
        phrasalOutput += " " + self.firstAdverb.phrasalOutput
        phrasalOutput += " " + self.secondAdverb.phrasalOutput
        return phrasalOutput
    }
    
    init(withAdverb firstAdverb: Adverb, conjunction: Conjunction, andAdverb secondAdverb: Adverb) {
        // TODO: handle conjunction here ("and" or "or" or "not" differences and negate second or first accordingly)
        self.firstAdverb = firstAdverb
        self.secondAdverb = secondAdverb
        
        super.init(self.firstAdverb.word + " " + self.secondAdverb.word)
    }
}