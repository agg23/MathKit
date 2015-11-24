//
//  Tokenizer.swift
//  MathKit
//
//  Created by Adam Gastineau on 11/24/15.
//  Copyright © 2015 Adam Gastineau. All rights reserved.
//

import Cocoa

class Tokenizer: NSObject {
    let separators = NSSet(array: ["+", "-", "*", "/"])
    
    let whitespaceCharacters = NSCharacterSet.whitespaceAndNewlineCharacterSet()
    
    func tokenizeString(string:String) -> Array<String> {
        
        var array = Array<String>()
        
        var currentToken = ""
        for char in string.characters {
            let characterString = String(char)
            if self.separators.containsObject(characterString) {
                array.append(currentToken.stringByTrimmingCharactersInSet(self.whitespaceCharacters))
                currentToken = ""
                array.append(characterString)
            } else {
                currentToken += characterString
            }
        }
        
        // Add last token
        if currentToken != "" {
            array.append(currentToken.stringByTrimmingCharactersInSet(self.whitespaceCharacters))
        }
        
        return array
    }
}
