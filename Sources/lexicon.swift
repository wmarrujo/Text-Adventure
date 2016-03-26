let lexicon: [String: Set<PhrasalCategory>] = [
    "look":[Verb("look")],
    //"examine":[Verb],
    //"glance":[Verb],
    "read":[Verb("read")],
    //"save":[Verb],
    //"restore":[Verb],
    "quit":[Verb("quit")],
    //"restart":[Verb],
    "take":[Verb("take")],
    "get":[Verb("take")],
    "drop":[Verb("drop")],
    "transfer":[Verb("transfer")],
    "go":[Verb("go")],
    "move":[Verb("go"), Verb("transfer")],
    "open":[Verb("open"), Adjective("open")],
    "close":[Verb("close")],
    "insert":[Verb("insert")],
    "put":[Verb("insert")],
    //"push":[Verb],
    //"pull":[Verb],
    //"turn":[Verb],
    //"feel":[Verb],
    //"eat":[Verb],
    //"drink":[Verb],
    //"smell":[Verb],
    //"listen":[Verb],
    //"climb":[Verb],
    //"break":[Verb],
    //"burn":[Verb],
    "lock":[Verb("lock"), Noun("lock")],
    "unlock":[Verb("unlock")],
    //"wave":[Verb],
    //"wear":[Verb],
    //"dig":[Verb],
    "enter":[Verb("enter")],
    "exit":[Verb("exit"), Verb("quit")],
    //"search":[Verb],
    //"jump":[Verb],
    //"say":[Verb],
    //"yell":[Verb],
    //"whisper":[Verb],
    //"tell":[Verb],
    //"show":[Verb],
    //"help":[Verb, Noun],
    //"give":[Verb],
    //"kill":[Verb],
    //"attack":[Verb],
    //"kiss":[Verb],
    //"knock":[Verb],
    //"lick":[Verb],
    //"remove":[Verb],
    //"sit":[Verb],
    //"sleep":[Verb],
    //"wait":[Verb],
    //"taste":[Verb],
    "throw":[Verb("throw")],
    //"toss":[Verb],
    //"tie":[Verb, Noun],
    //"untie":[Verb],
    //"touch":[Verb],
    //"prod":[Verb],
    //"poke":[Verb],
    //"nudge":[Verb],
    //"blow":[Verb],
    //"buy":[Verb],
    //"cut":[Verb],
    //"rub":[Verb],
    //"wake":[Verb],
    //"swim":[Verb],
    //"squeeze":[Verb],
    //"crush":[Verb],
    //"mash":[Verb],
    //"set":[Verb],
    //"is":[Verb],
    
    "red":[Adjective("red")],
    "green":[Adjective("green")],
    "blue":[Adjective("blue")],
    "yellow":[Adjective("yellow")],
    "orange":[Adjective("orange"), Noun("orange")],
    "purple":[Adjective("purple")],
    "violet":[Adjective("purple")],
    "brown":[Adjective("brown")],
    "silver":[Adjective("silver"), Noun("silver")],
    "gold":[Adjective("gold"), Noun("gold")],
    "golden":[Adjective("gold")],
    "white":[Adjective("white")],
    "black":[Adjective("black")],
    "light":[Adjective("light"), Verb("light")],
    "dark":[Adjective("dark")],
    "clear":[Adjective("transparent"), Verb("clear")],
    "transparent":[Adjective("transparent")],
    "transluscent":[Adjective("transparent")],
    //"new":[Adjective],
    //"old":[Adjective],
    //"big":[Adjective],
    //"large":[Adjective],
    //"small":[Adjective],
    //"little":[Adjective],
    //"young":[Adjective],
    //"long":[Adjective],
    //"tall":[Adjective],
    //"broad":[Adjective],
    //"short":[Adjective],
    //"only":[Adjective],
    //"strong":[Adjective],
    //"sturdy":[Adjective],
    //"weak":[Adjective],
    //"dead":[Adjective],
    //"best":[Adjective],
    //"worst":[Adjective],
    //"strongest":[Adjective],
    //"weakest":[Adjective],
    //"oldest":[Adjective],
    //"newest":[Adjective],
    //"most":[Adjective],
    "closed":[Adjective("closed")],
    
    //"not":[Adverb],???
    
    "up":[Preposition("up")],
    "down":[Preposition("down")],
    "north":[Preposition("north")],
    "south":[Preposition("south")],
    "east":[Preposition("east")],
    "west":[Preposition("west")],
    "in":[Preposition("in")],
    "above":[Preposition("above")],
    "below":[Preposition("below")],
    "at":[Preposition("at")],
    "to":[Preposition("to")],
    "from":[Preposition("from")],
    //"left":[Preposition],
    //"right":[Preposition],
    "on":[Preposition("on"), Adverb("on"), Adjective("on")],
    "of":[Preposition("of")],
    //"about":[Preposition],
    //"around":[Preposition],
    //"except":[Preposition],
    //"with":[Preposition],
    //"using":[Preposition],
    
    "the":[Determiner("the")],
    "a":[Determiner("a")],
    "an":[Determiner("an")],
    "that":[Determiner("that"), Conjunction("that")],
    "my":[Determiner("my")],
    
    "and":[Conjunction("and")],
    "but":[Conjunction("but")],
    "then":[Conjunction("then")],
    
    "everything":[Noun("everything")],
    
    // SIMPLIFICATIONS
    // already parsed shortened versions of some common commands
    
    "n":[RegularVerbPhrase(withVerb: Verb("go"), withPrepositionalPhrase: RegularPrepositionalPhrase(withPreposition: Preposition("north")))],
    "s":[RegularVerbPhrase(withVerb: Verb("go"), withPrepositionalPhrase: RegularPrepositionalPhrase(withPreposition: Preposition("south")))],
    "e":[RegularVerbPhrase(withVerb: Verb("go"), withPrepositionalPhrase: RegularPrepositionalPhrase(withPreposition: Preposition("east")))],
    "w":[RegularVerbPhrase(withVerb: Verb("go"), withPrepositionalPhrase: RegularPrepositionalPhrase(withPreposition: Preposition("west")))],
    "u":[RegularVerbPhrase(withVerb: Verb("go"), withPrepositionalPhrase: RegularPrepositionalPhrase(withPreposition: Preposition("up")))],
    "d":[RegularVerbPhrase(withVerb: Verb("go"), withPrepositionalPhrase: RegularPrepositionalPhrase(withPreposition: Preposition("down")))],
    "i":[RegularVerbPhrase(withVerb: Verb("take"), withNounPhrase: RegularNounPhrase(withNoun: Noun("inventory")))],
    "l":[RegularVerbPhrase(withVerb: Verb("look"))],
    
    // and some things (nouns) for testing ---------------------
    
    "inventory":[Noun("inventory")],
    "self":[Noun("self")],
    "pick":[Noun("pick"), Verb("unlock")],
    "broom":[Noun("broom")],
    "room":[Noun("room")],
    "door":[Noun("door")],
    "chair":[Noun("chair")],
    "me":[Noun("me")],
    "egg":[Noun("egg")],
    "pan":[Noun("pan")],
    "spoon":[Noun("spoon")],
    "fork":[Noun("fork")],
    "knife":[Noun("knife")],
    "sword":[Noun("sword")],
    "longsword":[Noun("longsword")],
    "bow":[Noun("bow")],
    "longbow":[Noun("longbow")],
    "mary":[Noun("mary")],
    "foe":[Noun("foe")]
    
    // some more specfic things for testing edge cases --------
    
    
]