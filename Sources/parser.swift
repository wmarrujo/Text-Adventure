func parse(string: String, player: Player) throws -> VerbPhrase{
    
    // TOKENIZING
    let words = string.lowercaseString.stringByTrimmingCharactersInSet(whitespace).componentsSeparatedByCharactersInSet(whitespace)
    
    // DICTIONARY LOOKUP
    let tokens: [Set<PhrasalCategory>] = try words.map({
        (word: String) throws -> Set<PhrasalCategory> in
        
        guard let token = lexicon[word] else {
            throw SyntaxError.NoMatchesInLexicon(word: word)
        }
        
        return token
    }) // FIXME: account for this
    
    // PARSING
    let phrase = try construct(tokens)
    
    guard let command = phrase as? VerbPhrase else {
        throw SemanticsError.NotACommand(phrase: phrase)
    }
    
    return command
}

func construct(tokens: [Set<PhrasalCategory>]) throws -> PhrasalCategory {
    var sentence = tokens
    
    // ---------------- PARSE
    
    var index: Int = sentence.endIndex
    var length: Int = index
    
    repeat {
        // FIND LARGEST MATCH IN SENTENCE --------------------------------
        
        length = index // start with the full section left of the index
        var replacement: (Range<Int>, with: [Set<PhrasalCategory>]) = ((index - length)..<index, with: [])
        repeat {
            let newReplacement = try applyRules(Array(sentence[(index - length)..<index]))
            if newReplacement.isEmpty {
                length -= 1 // test the next one
            } else {
                replacement = ((index - length)..<index, with: [newReplacement])
            }
        } while length > 0 && replacement.with.isEmpty // end looking if it finds a match or section reaches length 1 with no match
        
        // DECIDE WHAT TO DO IF IT FOUND A MATCH OR NOT ------------------
        
        if replacement.with.isEmpty {
            index -= 1 // start 1 farther left
        } else {
            sentence.replaceRange(replacement.0, with: replacement.with) // group the stuff in the range as a phrasal group (identify it as a phrase)
            index = sentence.endIndex // start over with this new sentence
        }
        
    } while index > 0 // end when the last index is at the very end, either because it's the last one and found the last match or because it couldn't find any more matches
    
    // ---------------- MAKE SURE THE SENTENCE WAS PARSED CORRECTLY
    
    if sentence.count > 1 { // not enough
        throw GrammarError.TooManyTokensLeft(tokens: sentence)
    } else if sentence.count < 1 { // nothing was inputted?
        throw GrammarError.NoTokensInSentence
    } else if sentence[0].count != 1 {
        throw GrammarError.MultipleBuildsPossible(sentence: sentence[0])
        // TODO: check to see if there is only 1 with a verb phrase, and choose that one
    }
    
    // ---------------- RETURN THE PARSED PHRASE
    
    return sentence[0].first!
}

func applyRules(tokens: [Set<PhrasalCategory>]) throws -> Set<PhrasalCategory> { // applies grammar rules to a set of tokens and returns all possible grammar constructions (phrases)
    var possibleCompoundPhrases: Set<PhrasalCategory> = []
    
    for rule in grammar {
        if rule.matches(tokens) {
            possibleCompoundPhrases.insert(try rule.buildPhrase(tokens))
        }
    }
    
    return possibleCompoundPhrases
}

// ERROR HANDLING

enum SyntaxError: ErrorType {
    case NoMatchesInLexicon(word: String) // Misspelled?
}

enum GrammarError: ErrorType {
    case FailedInBuildingPhrase(phrase: [Set<PhrasalCategory>]) // should never appear, because we're checking for that in applyRules with rule.matches()
    case TooManyTokensLeft(tokens: [Set<PhrasalCategory>]) // failed at finding any applicable grammar rules and stopped parsing
    case NoTokensInSentence // probably nothing was inputted (or maybe a grammar rule returned an empty set, though that's not possible)
    case MultipleBuildsPossible(sentence: Set<PhrasalCategory>) // the possible sentences it found were not empty and it doesn't know which one to choose
}

enum SemanticsError: ErrorType {
    case NotACommand(phrase: PhrasalCategory) // cannot be converted to VerbPhrase
}

/*
Some Tests

DROP THE BIGGEST OF THE LIT STICKS IN THE BOAT THEN DROP THE LEAST BEST WEAPON IN THE RIVER
THROW KNIFE AT MARY
THROW KNIFE TO MARY
TAKE INVENTORY
GET LONGSWORD
G LS
DROP EVERYTHING BUT MY SWORD
GET GOLDEN FORK
BLIND FOE
PUT THE EGG IN THE PAN WITH THE SPOON
GET INSECTS WITH NETS
OPEN DOOR
OPEN DOOR WITH SMALL KEY
*/