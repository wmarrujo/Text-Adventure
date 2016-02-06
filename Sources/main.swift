import Foundation

// Utility Functions

////////////////////////////////////////////////////////////////
// SETUP
////////////////////////////////////////////////////////////////

// Launch Arguments
let args = Process.arguments

// Game Variables
//var currentPlayer: Player = Player(name: prompt("name: "), andDscription: "", withHealth: 100, atLocation: ) // FIXME: use default description (don't know why it's crashing)

////////////////////////////////////////////////////////////////
// GAME LOOP
////////////////////////////////////////////////////////////////

func gameLoop() {
  while(true) {
      print("launch")
  }
}

////////////////////////////////////////////////////////////////
// TESTS
///////////////////////////////////////////////////////////////

/* [[[TEST FAILED]]]

  let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
  dispatch_async(dispatch_get_global_queue(priority, 0)) {
  	// do some task
  	dispatch_async(dispatch_get_main_queue()) {
  		// update some UI
  	}
  }
*/


  var GlobalUtilityQueue: dispatch_queue_t {
    return dispatch_get_global_queue(nil, Int(QOS_CLASS_UTILITY.value), 0)
  }

  dispatch_async(GlobalUtilityQueue) {
    gameLoop()
  }






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
/*
var broom = Item(withName: "Broom", thatLooksLike: "A sturdy, old broomstick", ofSize: 3, thatWeighs: 3)
var itemSet: Set<Item> = [broom]

var location = Location(withName: "Sample Room", thatLooksLike: "A plain, boring, empty room.", ofSize: 10, containing: itemSet)
*/
