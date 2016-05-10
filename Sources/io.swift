import Foundation

// PLAYER INTERFACE

func message(messages: String...) { // prints a message to the terminal
    // TODO; figure out how to print above input line
    let message = messages[Int.random(0..<messages.count)]
    print(message)
}

func prompt(prompt: String, withNewlineAfterPrompt newline: Bool = false) -> String {
    if newline {
        print(prompt) // with newline
    } else {
        print(prompt, terminator: "") // without newline
    }
    
    if let input = readLine() { // get input
        return input
    } else { // if input fails for some reason
        return ""
    }
}

// FILE INTERFACE

func save(contents: String, to path: String) -> String {
    do {
        try contents.writeToFile(path, atomically: true, encoding: NSUTF8StringEncoding)
        return "successfully wrote to file \"\(path)\""
    } catch {
        return "error saving file at path \"\(path)\" with error: \(error)"
    }
}

func saveInCurrentDirectory(contents: String, to filename: String) -> String {
    return save(contents, to: NSFileManager.defaultManager().currentDirectoryPath + filename)
}