public class Food: Item {
  func consume() {}

  convenience init(withID id: Int, withName name: String, thatLooksLike description: String, ofSize size: Int, thatWeighs weight: Int) {
      self.init(id: id, name: name, description: description, size: size, weight: weight)
  }
}
