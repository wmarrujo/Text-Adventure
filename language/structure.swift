// Overarching Type Class

class SYStructure { // Defines Node in the Tree

}

// Container Nodes

class SYAction: SYStructure {
    let command: SYCommand
    let selector: SYSelector

    init(command: SYCommand, selector: SYSelector) {
        self.command = command
        self.selector = selector
    }

    func doAction() { // do action on selector

    }
}

class SYSelector: SYStructure {
    let reference:

    init(thing: SYThing) {
        self.reference =
    }

    init(things: SYThings) {

    }

    init(thing: SYThing, specifiers: SYSpecifier...) {

    }

    init(things: SYThing, specifiers: SYSpecifier...) {

    }
}

// Individual Nodes

class SYThing: SYStructure {
    let thing: String

    init(word: String) {
        self.thing = word
    }
}

class SYThings: SYStructure {
    let thing: String

    init(word: String) {
        let thing = word
    }
}

class SYCommand: SYStructure {
    let command: String

    init(command: String) {
        self.command = command
    }
}

class SYSpecifier: SYStructure {
    let specifier: String

    init(specifier: String) {
        self.specifier = specifier
    }
}
