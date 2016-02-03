public class Automata: Thing {

    ////////////////////////////////////////////////////////////////
    // INSTANCE VARIABLES
    ////////////////////////////////////////////////////////////////

    var health: Int
    var location: Location

    ////////////////////////////////////////////////////////////////
    // INITIALIZERS
    ////////////////////////////////////////////////////////////////

    convenience init(withID id: Int, withName name: String, thatLooksLike description: String, ofSize size: Int, withHealth health: Int = 100, isInTheLocation location: Location) {
        self.init(id: id, name: name, description: description, size: size)
        self.health = health
        self.location = location
        super.init()
    }

    ////////////////////////////////////////////////////////////////
    // METHODS
    ////////////////////////////////////////////////////////////////
    
    func move(direction: String) {
        self.location.go(direction)
    }
    
}
