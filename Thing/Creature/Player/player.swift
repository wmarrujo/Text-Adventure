public class Player: Creature {

    //LOGIN ITEMS - Ensures that only one player will have access to each character in-game
    /*
    var username
    var password
    */

    convenience init(name: String, description: String, size: Int, health: Int, location: Location) {
        self.init(name: name, description: description, size: size, health: health, location: location)
    }
}
