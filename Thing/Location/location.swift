public class Location: Thing {
    var creatures = Set<Creature> = nil
    var items = Set<Item> = nil
    var locations = Dictionary<List<Location>> = nil

    convenience init(name: String, description: String, size: Int, creatures: Set<Creature>()?, items: Set<Item>()?, locations: Dictionary<List<Location>()>()?) {
      self.init(name: name, description: description, size: size, creatures: creatures, items: items, locations: locations)
    }
}
