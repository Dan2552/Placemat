//
//  DictionaryFilter.swift
//  Pods
//
//  Created by Daniel Inkpen on 09/06/2015.
//
//

import Foundation

public extension NSDictionary {

    func only(keys: [String]) -> NSDictionary {
        let newDict = NSMutableDictionary()
        for (keyObject, value) in self {
            if let key = keyObject as? String {
                if keys.contains(key) {
                    newDict[key] = value
                }
            }
        }
        
        return newDict
    }
    
    func stringKeys() -> [String] {
        var keys = [String]()
        for (keyObject, _) in self {
            if let key = keyObject as? String {
                keys.append(key)
            }
        }
        return keys
    }

    func underscoreKeys() -> [String: AnyObject] {
        var attributesUnderscore = [String: AnyObject]()

        let selfCasted = self as! [String: AnyObject]
        for (key, value) in selfCasted {
            attributesUnderscore[key.underscoreCased()] = value
        }

        return attributesUnderscore
    }

}
