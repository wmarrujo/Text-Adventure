public class Location: Thing {
    var creatures = Set<Creature> = nil
    var items = Set<Item> = nil
    var locations = Dictionary<List<Location>> = nil

    convenience init(creatures: Set<Creature>()?, items: Set<Item>()?, locations: Dictionary<List<Location>()>()?) {
      self.init(creatures: creatures, items: items, locations: locations)
    }
}
