import Foundation

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
// SETUP
////////////////////////////////////////////////////////////////

// Launch Arguments
let args = Process.arguments

// Game Variables
var currentPlayer: Player = Player(name: prompt("name: "))

////////////////////////////////////////////////////////////////
// GAME LOOP
////////////////////////////////////////////////////////////////

parse(prompt("> "))

////////////////////////////////////////////////////////////////
// TESTS
////////////////////////////////////////////////////////////////

/*
  var thing = Thing("name", "description", 0)
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

var broom = Item(withName: "Broom", thatLooksLike: "A sturdy, old broomstick", ofSize: 3, thatWeighs: 3)
var itemSet: Set<Item> = [broom]

var location = Location(withName: "Sample Room", thatLooksLike: "A plain, boring, empty room.", ofSize: 10, containing: itemSet)
