import CoreFoundation
import SwiftyJSON

////////////////////////////////////////////////////////////////
// SETUP
////////////////////////////////////////////////////////////////

// Launch Arguments
let args = Process.arguments

// Game Variables

let defaultGame = JSON.parse("{\"starting locations\":[0],\"things\":[{\"id\":0,\"type\":\"Location\",\"name\":\"Reception Room\",\"description\":\"This is where you wait while others join or while you load a game from a save file\"}]}")

////////////////////////////////////////////////////////////////
// DEPENDENCIES
////////////////////////////////////////////////////////////////

func enterUsername() -> String {
    print("Enter username: ", terminator: "")
    var username = ""
    
    username = prompt("")
    
    return username
}

func validateUsername(username: String) -> Bool {
    if username == "" {
        return false
    }
    // TODO: make sure it doesn't match a keyword
    
    return true
}

////////////////////////////////////////////////////////////////
// GAME
////////////////////////////////////////////////////////////////

// TODO: show introductory message
// TODO: show room information

// Get username

clearScreen()
moveCursorToHome()

var username = ""
var validUsername = false
repeat {
    username = enterUsername()
    
    validUsername = validateUsername(username)
    if !validUsername {
        print("invalid username")
    }
    
} while !validUsername

// Create User's Game Instance

let game = Game(withJSON: defaultGame, andUserWithName: username)

// Begin the game Execution

game.begin()