func parse(string: String, player: Player) {
    
    // TOKENIZING
    let words = string.lowercaseString.stringByTrimmingCharactersInSet(whitespace).componentsSeparatedByCharactersInSet(whitespace)
    
    // DICTIONARY LOOKUP
    let tokens: [Set<PhrasalCategory>] = words.map({ lexicon[$0]! }) // FIXME: account for this
    
    // PARSING
    let phrase = construct(tokens)
    
    if !(phrase is VerbPhrase) {
        message("please enter a command")
    }
    
    let command = phrase as! VerbPhrase
    
    // EXECUTING
    
    command.perform(player)
}

func construct(tokens: [Set<PhrasalCategory>]) -> PhrasalCategory {
    var sentence = tokens
    
    // ---------------- PARSE
    
    var index: Int = sentence.endIndex
    var length: Int = index
    
    repeat {
        // FIND LARGEST MATCH IN SENTENCE --------------------------------
        
        length = index // start with the full section left of the index
        var replacement: (Range<Int>, with: [Set<PhrasalCategory>]) = ((index - length)..<index, with: [])
        repeat {
            let newReplacement = applyRules(Array(sentence[(index - length)..<index]))
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
            // FIXME: sentence.replaceRange(replacement) // won't work
            sentence.replaceRange(replacement.0, with: replacement.with)
            index = sentence.endIndex // start over with this new sentence
        }
        
    } while index > 0 // end when the last index is at the very end, either because it's the last one and found the last match or because it couldn't find any more matches
    
    // ---------------- MAKE SURE THE SENTENCE WAS PARSED FULLY
    
    if sentence.count != 1 { // not enough or too many were matched, they have bad grammar
        message("the grammar you used could not be matched to any of our grammar rules or your usage is ambiguous")
        return Noun("error") // abort
    }
    
    // ---------------- RETURN THE PARSED PHRASE
    
    return sentence[0].first!
}

func applyRules(tokens: [Set<PhrasalCategory>]) -> Set<PhrasalCategory> { // applies grammar rules to a set of tokens and returns all possible grammar constructions (phrases)
    var possibleCompoundPhrases: Set<PhrasalCategory> = []
    
    for rule in grammar {
        if rule.matches(tokens) {
            possibleCompoundPhrases.insert(rule.buildPhrase(tokens))
        }
    }
    
    return possibleCompoundPhrases
}

// TODO: make proper error handling, quite unsafe for the moment, and not very good user replies for errors

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