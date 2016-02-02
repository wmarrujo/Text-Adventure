public class Position: Location {
    //TODO: Figure out how these would work in-game

    //TEMP
    convenience init(name: String, description: String, size: Int, creatures: Set<Creature>()?, items: Set<Item>()?, locations: Dictionary<List<Location>()>()?) {
      self.init(name: name, description: description, size: size, creatures: creatures, items: items, locations: locations)
    }
}
