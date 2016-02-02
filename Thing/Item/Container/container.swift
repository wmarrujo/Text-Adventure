public class Container: Item {
    var items = Set<Item>()

    convenience init(name: String, description: String, size: Int, weight: Int, items: Set<Item>) {
        self.init(name: name, description: description, size: size, weight: weight, items: items)
    }
}
