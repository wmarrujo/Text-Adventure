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