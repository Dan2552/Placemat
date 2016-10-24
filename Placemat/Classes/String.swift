import UIKit
private let acronyms = [
    "URL",
    "HTTP",
    "SSL",
    "HTML",
    "API"
]

public enum FirstCharacterCase {
    case lower
    case upper
}

public extension String {
    static func nameFor(object: Any) -> String {
        return (object is Any.Type) ? "\(object)" : "\(type(of: object))"
    }
    
    func changingCaseOf(firstCharacter: FirstCharacterCase) -> String {
        guard self.characters.count > 0 else { return self }

        let rest = characters.index(after: startIndex)..<endIndex
        if firstCharacter == .lower {
            return self[startIndex...startIndex].lowercased() + self[rest]
        } else {
            return self[startIndex...startIndex].uppercased() + self[rest]
        }
    }
    
    func camelCased(firstCharacterCase: FirstCharacterCase = .upper) -> String {
        let range = rangeOfCharacter(from: NSCharacterSet.uppercaseLetters)
        let hasNoCapitals = range?.isEmpty
        var result: String = self
        if hasNoCapitals == true || hasNoCapitals == nil {
            result = self.capitalized
        }
        
        return result.changingCaseOf(firstCharacter: firstCharacterCase).replacingOccurrences(of: "_", with: "")
    }
    
    func pluralize() -> String {
        if hasSuffix("s") {
            if !hasSuffix("ss") { return self }
        }
        var plural = "\(self)s"
        if plural.hasSuffix("eys") { // "moneys" -> "monies"
            let range = plural.index(endIndex, offsetBy: -2)..<plural.endIndex
            plural = plural.replacingCharacters(in: range, with: "ies")
        } else if plural.hasSuffix("ys") { // "categorys" -> "categories"
            let range = plural.index(endIndex, offsetBy: -1)..<plural.endIndex
            plural = plural.replacingCharacters(in: range, with: "ies")
        } else if plural.hasSuffix("sss") { // "address" -> "addresses"
            let range = plural.index(endIndex, offsetBy: -2)..<plural.endIndex
            plural = plural.replacingCharacters(in: range, with: "sses")
        }
        return plural
    }
    
    func underscoreCased() -> String {
        let output = NSMutableString()
        let uppercase = NSCharacterSet.uppercaseLetters as NSCharacterSet
        var previousCharacterWasUppercase = false
        var currentCharacterIsUppercase = false
        
        for (index, character) in self.characters.enumerated() {
            let units = [unichar](String(character).utf16)
            
            previousCharacterWasUppercase = currentCharacterIsUppercase
            
            currentCharacterIsUppercase = uppercase.characterIsMember(units[0])
            
            if !previousCharacterWasUppercase && currentCharacterIsUppercase && index > 0 {
                output.append("_")
            } else if previousCharacterWasUppercase && !currentCharacterIsUppercase {
                if output.length > 1 {
                    let charTwoBack = output.character(at: output.length - 2)
                    if !NSCharacterSet(charactersIn: "_").characterIsMember(charTwoBack) {
                        output.insert("_", at: output.length - 1)
                    }
                }
            }
            
            output.append(String(character).lowercased())
        }
        return String(output)
    }
    
    public func humanize(firstCharacterCase: FirstCharacterCase = .upper) -> String {
        var human = self.underscoreCased()
        human = human.replacingOccurrences(of: "_", with: " ")
        human = human.lowercased()
        
        let words = human.components(separatedBy: " ")
        
        for (index, var word) in words.enumerated() {
            let upper = word.uppercased()
            if acronyms.contains(upper) {
                word = upper
            }
            
            if index == 0 {
                human = word
            } else {
                human += " \(word)"
            }
        }
        
        return human.changingCaseOf(firstCharacter: firstCharacterCase)
    }
    
    public func titleize() -> String {
        var string = underscoreCased().humanize().capitalized
        
        let words = string.components(separatedBy: " ")
        
        for (index, var word) in words.enumerated() {
            let upper = word.uppercased()
            if acronyms.contains(upper) {
                word = upper
            }
            
            if index == 0 {
                string = word
            } else {
                string += " \(word)"
            }
        }
        
        return string
    }
}
