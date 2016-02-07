func parse(string: String) {
    
    // TOKENIZING
    let words = string.lowercaseString.stringByTrimmingCharactersInSet(whitespace).componentsSeparatedByCharactersInSet(whitespace)
    dump(words)
    
    // DICTIONARY LOOKUP
    let tokens = words.map({lexicon[$0]})
    dump(tokens)
    
    // PARSING
    
    
    // BINDING
    
    
    // DISPATCHING
    
    
    // EXECUTING
    
    
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