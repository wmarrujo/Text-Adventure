public class Thing {
    var name: String = ""
    var description: String = ""
    var size: Int = 0

    convenience init(name: String, description: String, size: Int) {
        self.init(name: name, description: description, size: size)
    }
}

/*
NOTES

-Decide which combat system to use
-Work out how Positions vs. Locations work
-Implement AI for NPCs?
*/
