import CoreFoundation


////////////////////////////////////////////////////////////////
// TESTS
///////////////////////////////////////////////////////////////

var broom = Item(named: "broom", withDescription: "A sturdy, old broom", andWeight: 5, withAttributes: ["sturdy", "old"])
var initialLocation = Location(named: "Start Box", withDescription: "A plain, boring, empty room.", withContents: [broom])
var player = Player(named: "Jeff", withDescription: "you", withHealth: 100, atLocation: initialLocation, withEncumbrence: 12) // and no default inventory


// Utility Functions

////////////////////////////////////////////////////////////////
// SETUP
////////////////////////////////////////////////////////////////

// Launch Arguments
let args = Process.arguments

// Game Variables

////////////////////////////////////////////////////////////////
// GAME LOOP
////////////////////////////////////////////////////////////////

//print(["asdf", "asj", "word"].joinWithSeparator("   "))

while player.playing {
    player.input()
}