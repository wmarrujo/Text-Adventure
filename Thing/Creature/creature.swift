public class Creature: Thing {
    //TODO: Complete stats
    var health: Int
    var location: Location

    //TODO: Complete based on chosen combat system
    /*
    var attack: Integer
    var defense: Integer
    */

    convenience init(withID id: Int, withName name: String, thatLooksLike description: String, ofSize size: Int, withHealth health: Int = 100, isInTheLocation location: Location) {
        self.init(id: id, name: name, description: description, size: size)
        self.health = health
        self.location = location
        super.init()
    }
}
