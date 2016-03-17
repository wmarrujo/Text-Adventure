func message(message: String) { // prints a message to the terminal
    // TODO; figure out how to print above input line
    print(message)
    // TODO: make it a variable number of arguments so that if they put in multiple strings
    // TODO: it will choose one at random. making the game more funny or something
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