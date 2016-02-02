public class Weapon: Item {
  //TODO: Create variables based on chosen combat system

  //TEMP
  convenience init(withID id: Int, withName name: String, thatLooksLike description: String, ofSize size: Int, thatWeighs weight: Int) {
      self.init(id: id, name: name, description: description, size: size, weight: weight)
  }
}
