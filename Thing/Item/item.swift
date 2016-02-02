public class Item: Thing {
    let weight: Int = 0

    convenience init(withID id: Int, withName name: String, thatLooksLike description: String, ofSize size: Int, thatWeighs weight: Int) {
        self.init(id: id, name: name, description: description, size: size, weight: weight)
    }
}
