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
    let selector: SYSpecifier?
    
    // INITIALIZERS
    init(withCommand command: SYCommand, andSelector selector: SYSpecifier? = nil) {
        self.command = command
        self.selector = selector
    }
    
    convenience init(withCommand command: String, andSelector selector: SYSpecifier? = nil) {
        self.init(withCommand: SYCommand(command), andSelector: selector)
    }
    
    // METHODS
    
    func perform(caller: Player) {
        // FIXME: there's a bug where it won't find perform function, but it will if it's typecast.
        if let selector = self.selector {
            caller.perform(self.command.command, toItems: caller.findItemsWithRule(selector.match)) // call the command on the selected items (find items first)
        } else {
            caller.perform(self.command.command) // call command on the caller itself
        }
    }
}

// Individual Nodes


class SYSpecifier: SYStructure { // selects the correct object(s) from list of possible matches
    // DATA
    let match: (Item) -> Bool // TODO: change all to this, not working with sets, the find loop does that
    
    // INITIALIZERS
    init(_ match: (Item) -> Bool) {
        self.match = match
    }
    
    convenience init(_ match: (Item) -> Bool, andCondition otherCondition: (Item) -> Bool) {
        self.init({match($0) && otherCondition($0)}) // multiple conditions
    }
    
    // METHODS
    
}


class SYThing: SYSpecifier { // special selector to get things by their name
    // DATA
    
    // INITIALIZERS
    init(_ name: String) {
        super.init({(item: Item) -> Bool in
            return item.name == name
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
