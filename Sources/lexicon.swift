let lexicon: [String: SYStructure] = [
    // Phrases
    "pick up":SYCommand("take"),
    "take inventory":SYAction(withCommand: "show inventory"),
    
    // Things
    
    // Commands
    "take":SYCommand("take"),
    
    // Specifiers
    "all":SYSpecifier({(item: Item) -> Bool in true}),
    "green":SYSpecifier({(item: Item) -> Bool in item.attributes.contains("green")})
]

/*
let nouns: Set<String> = ["table", "chair", "apple", "potion", "door", "portal", "inventory", "tree", "shovel"] // things
let pluralNouns: Set<String> = ["tables", "chairs", "apples", "potions", "doors", "portals", "inventories", "trees", "shovel"] // more than one thing (doesn't have to make sense, that will be handled later)
let verbs: Set<String> = ["go", "take", "grab", "acquire", "insert", "place", "drop", "climb", "read", "look", "kill", "attack"] // actions
let adjectives: Set<String> = ["big", "small", "heavy", "light", "dark", "blue", "green", "red"] // specifiers
let prepositions: Set<String> = ["up", "down", "north", "south", "east", "west", "in", "out", "right", "left", "center", "above", "below"] // context
let articles: Set<String> = ["the", "an", "a"] // connectors to things
let conjunctions: Set<String> = ["and", "but", "or"] // connectors

// ALIASES

let aliases: [String:String] = ["l":"look", "i":"take inventory", "u":"go up", "d":"go down", "n":"go north", "s":"go south", "e":"go east", "w":"go west"]
let phrases: [String:LexicalCategory] = ["pick up":Verb] // useful phrases (they override other combinations)
*/