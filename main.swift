import Foundation

// Program Arguments
let args = Process.arguments

// Utility Functions
func prompt(prompt: String) -> String {
    print(prompt, terminator: "")
    let input = readLine(stripNewline: true)
    if input == nil {
        return ""
    }
    return input!
}

////////////////////////////////////////////////////////////////
// GAME LOOP
////////////////////////////////////////////////////////////////

parse(prompt("> "))


////////////////////////////////////////////////////////////////
// TESTS
////////////////////////////////////////////////////////////////
var thing = Thing("name", "description", 0)
  /*
  var item = Item()
  var weapon = Weapon()
  var food = Food()
  var furniture = Furniture()
  var container = Container()
  var location = Location()
  var position = Position()
  var creature = Creature()
  var player = Player()
  var npc = NPC()
  */
