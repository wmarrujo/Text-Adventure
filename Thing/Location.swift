public class Location: Thing {
    var creatures: Set<Creature>
    var items: Set<Item>
    var locations: directions

    init(withID id: Int, withName name: String, thatLooksLike description: String, ofSize size: Int, withCreatures creatures: Set<Creature> = Set<Creature>(), containing items: Set<Item> = Set<Item>(), withDoorsTo locations: directions = directions(north: nil, south: nil, east: nil, west: nil, up: nil, down: nil)) {
      self.init(id: id, name: name, description: description, size: size, creatures: creatures, items: items, locations: locations)
    }
}

struct directions {
  var north: Portal?
  var south: Portal?
  var east: Portal?
  var west: Portal?
  var up: Portal?
  var down: Portal?
}
