public class Automata: Thing {

    ////////////////////////////////////////////////////////////////
    // INSTANCE VARIABLES
    ////////////////////////////////////////////////////////////////

    var health: Int
    var location: Location

    ////////////////////////////////////////////////////////////////
    // INITIALIZERS
    ////////////////////////////////////////////////////////////////

<<<<<<< HEAD
    init(withName name: String, andDescription description: String = "", withHealth health: Int, atLocation location: Location) {
=======
    init(named name: String, andDscription description: String = "", withHealth health: Int, atLocation location: Location) {
>>>>>>> ec7b2a1854f4d56c2aba428c6e50abdd5b556642
        self.health = health
        self.location = location
        super.init(name, description)
    }

    ////////////////////////////////////////////////////////////////
    // METHODS
    ////////////////////////////////////////////////////////////////

    func move(direction: String) {
        self.location.go(direction, by: self)
    }

}
