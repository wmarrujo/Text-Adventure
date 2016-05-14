import Foundation
import SwiftyJSON

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

// ESCAPE SEQUENCES

let esc = "\u{001B}["

enum TextAttribute {
    case AllAttributesOff
    case Bold
    case Underscore
    case Blink
    case Reverse
    case Concealed // doesn't draw
    case ForegroundBlack
    case ForegroundRed
    case ForegroundGreen
    case ForegroundYellow
    case ForegroundBlue
    case ForegroundMagenta
    case ForegroundCyan
    case ForegroundWhite
    case BackgroundBlack
    case BackgroundRed
    case BackgroundGreen
    case BackgroundYellow
    case BackgroundBlue
    case BackgroundMagenta
    case BackgroundCyan
    case BackgroundWhite
}

func setTextMode(attributes: TextAttribute...) {
    var sequence: [String] = []
    
    for attribute in attributes {
        switch attribute {
            case .AllAttributesOff:  sequence.append("0")
            case .Bold:              sequence.append("1")
            case .Underscore:        sequence.append("4")
            case .Blink:             sequence.append("5")
            case .Reverse:           sequence.append("7")
            case .Concealed:         sequence.append("8")
            case .ForegroundBlack:   sequence.append("30")
            case .ForegroundRed:     sequence.append("31")
            case .ForegroundGreen:   sequence.append("32")
            case .ForegroundYellow:  sequence.append("33")
            case .ForegroundBlue:    sequence.append("34")
            case .ForegroundMagenta: sequence.append("35")
            case .ForegroundCyan:    sequence.append("36")
            case .ForegroundWhite:   sequence.append("37")
            case .BackgroundBlack:   sequence.append("40")
            case .BackgroundRed:     sequence.append("41")
            case .BackgroundGreen:   sequence.append("42")
            case .BackgroundYellow:  sequence.append("43")
            case .BackgroundBlue:    sequence.append("44")
            case .BackgroundMagenta: sequence.append("45")
            case .BackgroundCyan:    sequence.append("46")
            case .BackgroundWhite:   sequence.append("47")
            default:
                break
        }
    }
    
    print(esc + sequence.joinWithSeparator(";") + "m", terminator: "")
}

func clearScreen() {
    print("\(esc)2J", terminator: "")
}

func clearToEndOfLine() {
    print("\(esc)K", terminator: "")
}

func moveCursorToLine(line: Int) {
    print("\(esc)\(line)f", terminator: "")
}

func moveCursorToHome() { // home is top left (0, 0)
    print("\(esc)H", terminator: "")
}

func saveCursorPosition() {
    print("\(esc)s", terminator: "")
}

func restoreCursorPosition() {
    print("\(esc)u", terminator: "")
}

func moveCursorToBeginningOfLine() {
    print("\r", terminator: "")
}

// FILE INTERFACE

func save(contents: String, to path: String) throws {
    try contents.writeToFile(path, atomically: true, encoding: NSUTF8StringEncoding)
}

func saveInCurrentDirectory(contents: String, to filename: String) throws {
    try save(contents, to: NSFileManager.defaultManager().currentDirectoryPath + "/" + filename)
}

func read(path: String) throws -> String {
    return try String(contentsOfFile: path, encoding: NSUTF8StringEncoding)
}

func readInCurrentDirectory(filename: String) throws -> String {
    return try read(NSFileManager.defaultManager().currentDirectoryPath + "/" + filename)
}