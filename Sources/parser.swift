func parse(string: String, player: Player) throws -> VerbPhrase{
    
    // SIMPLIFICATION
    
    var simplifiedString = string
    
    // substitute aliases
    for (substring, alias) in aliases {
        simplifiedString = simplifiedString.stringByReplacingOccurrencesOfString(substring, withString: alias)
    }
    
    // remove whitespace before & after string
    simplifiedString = simplifiedString.stringByTrimmingCharactersInSet(whitespace)
    
    // TOKENIZING
    
    var words: [String] = []
    
    // separate string by whitespace, but combine quotations
    var inQuote: Bool = false
    var start: Int = 0
    for (index, char) in simplifiedString.characters.enumerate() {
        if !inQuote { // not in a quote
            if char == " " || char == "\t" || char == "\n" { // char is a whitespace character
                words += [simplifiedString.substringWithRange(simplifiedString.startIndex.advancedBy(start)..<simplifiedString.startIndex.advancedBy(index))] // split word
                start = index + 1 // mark the start of the next word
            } else if char == "\"" { // if it's the beginning of a quotation
                words += [simplifiedString.substringWithRange(simplifiedString.startIndex.advancedBy(start)..<simplifiedString.startIndex.advancedBy(index))] // split word
                inQuote = true // raise flag
                start = index // mark the start of the quote
            }
        } else { // in a quote
            if char == "\"" {
                words += [simplifiedString.substringWithRange(simplifiedString.startIndex.advancedBy(start)...simplifiedString.startIndex.advancedBy(index))] // split word
                inQuote = false // lower flag
                start = index + 1
            }
        }
    }
    words += [simplifiedString.substringWithRange(simplifiedString.startIndex.advancedBy(start)..<simplifiedString.endIndex)] // add last word
    
    // filter out multiple spaces
    words = words.filter({ $0 != "" })
    
    // DICTIONARY LOOKUP
    let tokens: [Set<PhrasalCategory>] = try words.map({
        (word: String) throws -> Set<PhrasalCategory> in
        var token: Set<PhrasalCategory> = [n("error")] // should always be overwritten
        
        if word.characters.first == "\"" && word.characters.last == "\"" { // if it is a quote
            token = [n(word)] // make a noun out of the quote
        } else if word.characters.first == "\"" { // && word.characters.last != "\"" // then they forgot a quotation mark
            throw SyntaxError.ForgotEndQuotation(string: word) // tell the user
        } else { // if it is a regular word
            guard let t = lexicon[word] else { // try to match with word in lexicon
                throw SyntaxError.NoMatchesInLexicon(word: word) // raise error if it doesn't match anything in the lexicon
            }
            token = t
        }
        
        return token
    })
    
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
        // TODO: check to see if there is only 1 with a verb phrase, and choose that one
        throw GrammarError.MultipleBuildsPossible(sentence: sentence[0])
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
    case ForgotEndQuotation(string: String) // Forgot to end their quotation
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