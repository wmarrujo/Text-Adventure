func parse(string: String) {
    
    // TOKENIZING
    let words = string.lowercaseString.stringByTrimmingCharactersInSet(whitespace).componentsSeparatedByCharactersInSet(whitespace)
    dump(words)
    print("\n\n")
    
    // DICTIONARY LOOKUP
    let tokens: [Set<PhrasalCategory>] = words.map({ lexicon[$0]! }) // FIXME: account for this
    dump(tokens)
    print("\n\n")
    
    // PARSING
    let phrase = construct(tokens)
    print("phrase: \(phrase)")
    
    //let syntaxTree = construct(tokens)
    
    // BINDING
    
    
    // DISPATCHING
    
    
    // EXECUTING
    
    
}

func construct(tokens: [Set<PhrasalCategory>]) -> Set<PhrasalCategory> {
    /*
    
    // ---------------- PARSE EACH SECTION INCREASING FROM THE RIGHT AND FROM AN INDEX FROM THE RIGHT
    var sentence = tokens
    var index = sentence.endIndex // the right edge of the range (1 more than the index that will be called)
    var length = 1 // the length of the range
    
    repeat {
        // ---------------- SETUP
        
        var newReplacement: Set<PhrasalCategory> = []
        var replacement: Set<PhrasalCategory> = []
        
        // ---------------- GO THROUGH EACH SECTION LEFT OF THE INDEX
        
        repeat {
            
            let section = sentence[(index - length)..<index] // FIXME: won't work inline
            print("testing section at (index: \(index), length:\(length)): \(section)")
            newReplacement = applyRules(Array(section)) // test the next length of section
            
            if !newReplacement.isEmpty { // for 1 word case where it will terminate due to (index - length) >= 0
                print("valid")
                replacement = newReplacement
            } else {
                print("invalid")
            }
            
            length += 1 // test 1 further to the left next time
        } while (index - length) >= 0 && !newReplacement.isEmpty // exit when the length of the range is longer than the beginning of the list to the index or when newReplacement becomes empty
        length -= 1 // undo the last modification to the left because the condition failed, we're using the last value
        if newReplacement.isEmpty { // if it exited the loop due to not matching something, not range overflow
            length -= 1 // shorten 1 extra
        }
        print("last valid section: \(sentence[(index - length)..<index])")
        
        // ---------------- DECIDE WHAT TO DO BASED ON THE FINAL REPLACEMENT(S) SELECTED
        
        if replacement.isEmpty || replacement.count == 1 { // no rule was matched, probably already a phrase
            index -= 1 // begin testing range from 1 further left now
        } else { // a rule was matched
            let range: Range<Int> = (index - length)..<index // FIXME: won't work inline
            sentence.replaceRange(range, with: [replacement]) // do the replacement
            print("sentence from replacing at (index: \(index), length:\(length)): \(sentence)")
            index = sentence.endIndex // "carriage return" to right (test from very end again with new replacements in place)
            length = 2 // start matching with a length of 2
        }
        
    } while index > 1 // while the index has not reached the end
    
    */
    
    
    
    
    
    
    
    
    
    
    
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
    
    if sentence.count > 1 { // not enough was matched, they have bad grammar
        message("the grammar you used could not be matched to any of our grammar rules")
        return [] // abort
    }
    
    // ---------------- RETURN THE PARSED PHRASE
    
    return sentence[0]
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


/*
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