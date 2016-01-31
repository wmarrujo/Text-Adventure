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

// Game Loop
parse(prompt("> "))
