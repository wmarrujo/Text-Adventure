func parse(string: String) {
    print("import test")
}

////////////////////////////////////////////////////////////////
// Syntactic Structure
////////////////////////////////////////////////////////////////

struct Word {
    let string: String
    let lexicalCategory: LexicalCategory

    func simpleDescription() {
        print("\(string):[\(lexicalCategory)]")
    }
}

enum LexicalCategory: String {
    case Noun, Verb, Preposition, Article, Conjunction, Adjective, Unknown

    func simpleDescription() -> String {
        switch self {
            case .Noun: return "Noun"
            case .Verb: return "Verb"
            case .Preposition: return "Preposition"
            case .Article: return "Article"
            case .Conjunction: return "Conjunction"
            case .Adjective: return "Adjective"
            case .Unknown: return "Unknown"
        }
    }
}

////////////////////////////////////////////////////////////////
// Lexicon
////////////////////////////////////////////////////////////////

let nouns: Set<String> = ["Table", "Chair", "Apple", "door"] // things
let verbs: Set<String> = ["go", "take", "climb"] // actions
let prepositions: Set<String> = ["up", "down", "north", "south", "east", "west", "in", "out", "right", "left", "center", "above", "below"] // context
let articles: Set<String> = ["the", "an", "a"] // connectors to things
let conjunctions: Set<String> = ["and", "but", "or"] // connectors
let adjectives: Set<String> = ["big", "small", "heavy", "light"] // specifiers

func getLexicalCategory(word: String) -> LexicalCategory {
    if nouns.contains(word) {
        return LexicalCategory.Noun
    } else if verbs.contains(word) {
        return LexicalCategory.Verb
    } else if prepositions.contains(word) {
        return LexicalCategory.Preposition
    } else if articles.contains(word) {
        return LexicalCategory.Article
    } else if conjunctions.contains(word) {
        return LexicalCategory.Conjunction
    } else if adjectives.contains(word) {
        return LexicalCategory.Adjective
    } else {
        return LexicalCategory.Unknown
    }
}
