public class Player: Creature {

    //LOGIN ITEMS - Ensures that only one player will have access to each character in-game
    /*
    var username
    var password
    */

    convenience init(withID id: Int, name: String, description: String, size: Int, health: Int, location: Location) {
        self.init(id: id, name: name, description: description, size: size, health: health, location: location)
    }
}
