//
//  StringConverters.swift
//  Pods
//
//  Created by Daniel Green on 06/06/2015.
//
//

import UIKit

public extension String {
    func firstCharacterUpperCase() -> String {
        if count(self) > 0 {
            let first = self.startIndex
            let rest = advance(first,1)..<self.endIndex
            return self[first...first].uppercaseString + self[rest]
        } else {
            return self
        }
    }
    
    func firstCharacterLowerCase() -> String {
        if count(self) > 0 {
            let first = self.startIndex
            let rest = advance(first,1)..<self.endIndex
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
            let range = advance(plural.endIndex, -3)..<advance(plural.endIndex, 0)
            plural = plural.stringByReplacingCharactersInRange(range, withString: "ies")
        } else if plural.hasSuffix("ys") { // "categorys" -> "categories"
            let range = advance(plural.endIndex, -2)..<advance(plural.endIndex, 0)
            plural = plural.stringByReplacingCharactersInRange(range, withString: "ies")
        } else if plural.hasSuffix("sss") { // "address" -> "addresses"
            let range = advance(plural.endIndex, -3)..<advance(plural.endIndex, 0)
            plural = plural.stringByReplacingCharactersInRange(range, withString: "sses")
        }
        return plural
    }
    
    func underscoreCase() -> String {
        var output = NSMutableString()
        let uppercase = NSCharacterSet.uppercaseLetterCharacterSet()
        var previousCharacterWasUppercase = false
        var currentCharacterIsUppercase = false
        
        var currentChar: Character?
        var previousChar: Character?
        
        for (index, character) in enumerate(self) {
            previousChar = currentChar
            currentChar = character
            
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
}
