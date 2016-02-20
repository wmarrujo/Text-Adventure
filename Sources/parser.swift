func parse(string: String) {
    
    // TOKENIZING
    let words = string.lowercaseString.stringByTrimmingCharactersInSet(whitespace).componentsSeparatedByCharactersInSet(whitespace)
    dump(words)
    
    // DICTIONARY LOOKUP
    let tokens = words.map({ lexicon[$0] })
    dump(tokens)
    
    // PARSING
    //let syntaxTree = construct(tokens)
    
    // BINDING
    
    
    // DISPATCHING
    
    
    // EXECUTING
    
    
}

/*
func construct(tokens: [Set<PhrasalCategory>])/* -> PhrasalCategory*/ {
    var sentence = tokens
    var index = sentence.count - 1
    
    while sentence.count != 1 {
        for rule in grammar {
            if matchGrammar(rule, toSentence: sentence) {
                
            }
        }
    }
    
    //return
}

func matchGrammar(grammar: Rule, toSentence tokens: [Set<PhrasalCategory>]) -> Bool {
    
}*/


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