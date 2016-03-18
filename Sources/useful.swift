import Foundation

let whitespace = NSCharacterSet.whitespaceAndNewlineCharacterSet()

func zipToDict<S0 : SequenceType, S1 : SequenceType where S0.Generator.Element : Hashable>(keys: S0, values: S1) -> [S0.Generator.Element:[S1.Generator.Element]] {
        var dict: [S0.Generator.Element:[S1.Generator.Element]] = [:]
        for (key, value) in zip(keys, values) {
          dict[key] = (dict[key] ?? []) + [value]
        }
        return dict
}

/*
func intercalate<S: SequenceType, A: Any where S.Generator.Element == A>(sequence: S, delimiter: A) {
    // TODO: implement later
}*/