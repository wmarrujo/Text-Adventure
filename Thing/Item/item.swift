public class Item: Thing {
    let weight: Int = 0

    convenience init(name: String, description: String, size: Int, weight: Int) {
        self.init(name: name, description: description, size: size, weight: weight)
    }
}
