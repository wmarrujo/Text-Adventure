func parse(string: String) {
    
    // TOKENIZING
    let words = string.lowercaseString.stringByTrimmingCharactersInSet(whitespace).componentsSeparatedByCharactersInSet(whitespace)
    dump(words)
    
    // DICTIONARY LOOKUP
    let tokens: [Set<PhrasalCategory>] = words.map({ lexicon[$0]! }) // FIXME: account for this
    dump(tokens)
    
    // PARSING
    let phrase = construct(tokens)
    print("phrase: \(phrase)")
    //let syntaxTree = construct(tokens)
    
    // BINDING
    
    
    // DISPATCHING
    
    
    // EXECUTING
    
    
}

func construct(tokens: [Set<PhrasalCategory>]) -> PhrasalCategory? {
    var sentence = tokens
    var index: Int = sentence.endIndex // the last item
    var length: Int = 1 // the range of the matching zone
    
    repeat {
        print("index: \(index)", terminator: "    ")
        section: repeat {
            print("length \(length)")
            let section = Array(sentence[(index - length)..<index]) // the section of the sentence we're looking at
            var newPhrase: PhrasalCategory? = nil
            
            print(section)
            for rule in grammar {
                print("checking rule: \(rule)")
                if rule.matches(section) { // matches grammar rule
                    print("rule matches!")
                    newPhrase = rule.buildPhrase(section) // builds the section into a single token
                    print("newPhrase: \(newPhrase)")
                    break // stop testing rules, you have your answer
                }
                // will match to the last rule in the grammar that matches (should be the most complicated possible)
            }
            
            print(newPhrase)
            if let np = newPhrase { // it did match. now start matching from the beginning with a modified sentence
                print("!!!: \(np)")
                // rewrite the section
                let r: Range<Int> = (index - length)..<index // FIXME: because for some reason this doesn't work inline
                sentence.replaceRange(r, with: [Set<PhrasalCategory>(arrayLiteral: np)]) // replace the range with the new token
                
                // reset everything
                index = sentence.endIndex // choose new end (the deincrementer right after the for loop will bring it back to the actual endIndex)
                length = 1 // reset length, the section collapsed to form 1 group and now only counts as 1 thing

                break section // quit back to within first do while loop
            } else { // if it didn't match anything
                message("error: no grammar matches found") // TODO: handle this error
            }
            
            length = length + 1 // try again with a larger section length
        } while length < index // until the range contains the entire list before the index
        
        index = index - 1
    } while sentence.count > 1 // until the index is pushed all the way to the beginning
    
    return sentence[0].first // return the phrasal category contained inside
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