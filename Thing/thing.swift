public class Thing: Hashable, Equatable {
    var name: String = ""
    var description: String = ""
    var size: Int = 0
    let id: Int

    public var hashValue: Int {
        return self.id
    }

    init(id: Int, name: String, description: String, size: Int) {
        self.init(id: id, name: name, description: description, size: size)
    }
}

public func ==(lhs: Thing, rhs: Thing) -> Bool {
  return lhs.hashValue == rhs.hashValue
}
/*
NOTES

-Decide which combat system to use
-Work out how Positions vs. Locations work
-Implement AI for NPCs?
*/
