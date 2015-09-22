//
//  StringConverters.swift
//  Pods
//
//  Created by Daniel Green on 06/06/2015.
//
//

import UIKit
private let acronyms = [
    "URL",
    "HTTP",
    "SSL",
    "HTML",
    "API"
]

public extension String {
    func firstCharacterUpperCase() -> String {
        if self.characters.count > 0 {
            let first = self.startIndex
            let rest = first.advancedBy(1)..<self.endIndex
            return self[first...first].uppercaseString + self[rest]
        } else {
            return self
        }
    }
    
    func firstCharacterLowerCase() -> String {
        if self.characters.count > 0 {
            let first = self.startIndex
            let rest = first.advancedBy(1)..<self.endIndex
            return self[first...first].lowercaseString + self[rest]
        } else {
            return self
        }
    }
    
    func camelCase() -> String {
        let range = rangeOfCharacterFromSet(NSCharacterSet.uppercaseLetterCharacterSet())
        if let r = range {
            if !r.isEmpty {
                return firstCharacterUpperCase()
            }
        }
        
        return capitalizedString.stringByReplacingOccurrencesOfString("_", withString: "")
    }
    
    func camelCaseLower() -> String {
        return camelCase().firstCharacterLowerCase()
    }
    
    func pluralize() -> String {
        if hasSuffix("s") {
            if !hasSuffix("ss") { return self }
        }
        var plural = "\(self)s"
        if plural.hasSuffix("eys") { // "moneys" -> "monies"
            let range = plural.endIndex.advancedBy(-3)..<plural.endIndex.advancedBy(0)
            plural = plural.stringByReplacingCharactersInRange(range, withString: "ies")
        } else if plural.hasSuffix("ys") { // "categorys" -> "categories"
            let range = plural.endIndex.advancedBy(-2)..<plural.endIndex.advancedBy(0)
            plural = plural.stringByReplacingCharactersInRange(range, withString: "ies")
        } else if plural.hasSuffix("sss") { // "address" -> "addresses"
            let range = plural.endIndex.advancedBy(-3)..<plural.endIndex.advancedBy(0)
            plural = plural.stringByReplacingCharactersInRange(range, withString: "sses")
        }
        return plural
    }
    
    func underscoreCase() -> String {
        let output = NSMutableString()
        let uppercase = NSCharacterSet.uppercaseLetterCharacterSet()
        var previousCharacterWasUppercase = false
        var currentCharacterIsUppercase = false
        
        for (index, character) in self.characters.enumerate() {
            let units = [unichar](String(character).utf16)
            
            previousCharacterWasUppercase = currentCharacterIsUppercase
            currentCharacterIsUppercase = uppercase.characterIsMember(units[0])
            
            if !previousCharacterWasUppercase && currentCharacterIsUppercase && index > 0 {
                output.appendString("_")
            } else if previousCharacterWasUppercase && !currentCharacterIsUppercase {
                if output.length > 1 {
                    let charTwoBack = output.characterAtIndex(output.length - 2)
                    if !NSCharacterSet(charactersInString: "_").characterIsMember(charTwoBack) {
                        output.insertString("_", atIndex: output.length - 1)
                    }
                }
            }
            
            output.appendString(String(character).lowercaseString)
        }
        return String(output)
    }
    
    // Deletes leading underscores, if any.
    // Removes a "_id" suffix if present.
    // Replaces underscores with spaces, if any.
    // Downcases all words except acronyms.
    // Capitalizes the first word.
    // TODO: Refactor the hell out of this with Regex
    public func humanize(capitalize: Bool = true) -> String {
        var human = self
        if human.hasPrefix("_") {
            human = (human as NSString).stringByReplacingCharactersInRange(NSMakeRange(0, 1), withString: "")
        }
        human = human.stringByReplacingOccurrencesOfString("_", withString: " ")
        human = human.lowercaseString
        let words = human.componentsSeparatedByString(" ")

        for (index, var word) in words.enumerate() {
            let upper = word.uppercaseString
            if acronyms.contains(upper) {
                word = upper
            }
            
            if index == 0 {
                human = word
            } else {
                human += " \(word)"
            }
        }
        
        if capitalize {
            human = human.firstCharacterUpperCase()
        }
        return human
    }
    
    // TODO: Refactor the hell out of this with Regex
    public func titleize() -> String {
        var string = underscoreCase().humanize().capitalizedString
        
        let words = string.componentsSeparatedByString(" ")
        
        for (index, var word) in words.enumerate() {
            let upper = word.uppercaseString
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
