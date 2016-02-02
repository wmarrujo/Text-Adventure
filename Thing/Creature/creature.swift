public class Creature: Thing {
    //TODO: Complete stats
    var health: Integer
    var location: Location

    //TODO: Complete based on chosen combat system
    /*
    var attack: Integer
    var defense: Integer
    */

    convenience init(name: String, description: String, size: Int, health: Int, location: Location) {
        self.init(name: name, description: description, size: size, health: health, location: location)
    }
}
