// Overarching Type Class

class SYStructure { // Defines Node in the Tree
    // DATA
    
    // INITIALIZERS
    
    // METHODS
}

// Container Nodes

class SYAction: SYStructure {
    // DATA
    let command: SYCommand
    let selection: SYSelector
    
    // INITIALIZERS
    
    // METHODS
    
    func perform(caller: Player, command: SYCommand, to selector: SYSpecifier) {
        caller.perform(command.command, to: caller.findItemsWithRule(selector.match))
    }
}

// Individual Nodes


class SYSpecifier: SYStructure { // selects the correct object(s) from list of possible matches
    // DATA
    let match: (Set<Item>) -> Set<Item>
    
    // INITIALIZERS
    init(_ match: (Set<Item>) -> Set<Item>) {
        self.match = match
    }
    
    init(_ match: (Set<Item>) -> Set<Item>, andCondition condition: (Set<Item>) -> Set<Item>) {
        self.match = match(condition)
    }
    
    // METHODS
    
}


class SYThing: SYSpecifier { // special selector to get things by their name
    // DATA
    
    // INITIALIZERS
    init(_ name: String) {
        super.init({(items: Set<Item>) -> Set<Item> in
            let matches: Set<Item>
            for item in items {
                if item.name == name {
                    matches.insert(item)
                }
            }
            return matches
        })
    }
    
    // METHODS
    
}

class SYCommand: SYStructure { // calls the correct function
    // DATA
    let command: String
    
    // INITIALIZERS
    init(_ command: String) {
        self.command = command
    }
    
    // METHODS
    
}
