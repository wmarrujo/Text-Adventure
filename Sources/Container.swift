public class Container: Item {
    var items = Set<Item>()

    convenience init(withID id: Int, withName name: String, thatLooksLike description: String, ofSize size: Int, thatWeighs weight: Int, thatContains items: Set<Item> = Set<Item>()) {
        self.init(id: id, name: name, description: description, size: size, weight: weight, items: items)
    }
}
