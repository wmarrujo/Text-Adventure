func message(message: String) { // prints a message to the terminal
    // TODO; figure out how to print above input line
    print(message)
}

func prompt(prompt: String, withNewlineAfterPrompt newline: Bool = false) -> String {
    if newline {
        print(prompt, terminator: "") // without newline
    } else {
        print(prompt) // with newline
    }
    
    if let input = readLine(stripNewline: true) { // get input
        return input
    } else { // if input fails for some reason
        return ""
    }
}