//
//  Tokenizer.swift
//  MathKit
//
//  Created by Adam Gastineau on 11/24/15.
//  Copyright © 2015 Adam Gastineau. All rights reserved.
//

import Cocoa

class Tokenizer: NSObject {
    let whitespaceCharacters = NSCharacterSet.whitespaceAndNewlineCharacterSet()
    
    func tokenizeString(string:String) -> Array<Token> {
        
        var array = Array<Token>()
        
        var currentToken = ""
        for char in string.characters {
            let characterString = String(char)
            
            if characterString == "(" {
                appendTokenToArray(&array, tokenString: currentToken, token: Token(type: TokenType.OpenParen, value: "("))
                currentToken = ""
                
            } else if characterString == ")" {
                appendTokenToArray(&array, tokenString: currentToken, token: Token(type: TokenType.CloseParen, value: ")"))
                currentToken = ""
                
            } else if kSeperator.containsObject(characterString) {
                appendTokenToArray(&array, tokenString: currentToken, token: Token(type: TokenType.Separator, value: ","))
                currentToken = ""
                
            } else if kSupportedOperators.containsObject(characterString) {
                appendTokenToArray(&array, tokenString: currentToken, token: Token(type: TokenType.Operator, value: characterString))
                currentToken = ""
                
            } else {
                currentToken += characterString
            }

        }
        
        // Add last token
        if currentToken != "" {
            array.append(tokenFromString(currentToken.stringByTrimmingCharactersInSet(self.whitespaceCharacters))!)
        }
        
        return array
    }
    
    private func appendTokenToArray(inout array: Array<Token>, tokenString: String?, token: Token) {
        let newToken = tokenFromString(tokenString!.stringByTrimmingCharactersInSet(self.whitespaceCharacters))
        if (newToken != nil) {
            array.append(newToken!)
        }
        array.append(token)
    }
    
    private func tokenFromString(string: String?) -> Token? {
        if string == nil || string == "" {
            return nil
        }
        
        if let double = Double(string!) {
            return Token(type: TokenType.Decimal, value: NSNumber(double: double))
        }
        
        
        // Line should be unnecessary due to check done by calling function (tokenizeString())
//        if kSupportedOperators.containsObject(string) {
//            // String is a standard operator
//            return Token(type: TokenType.Operator, value: string)
//        }
        
        if kStringOperators.containsObject(string!) {
            // String is a string based operator
            return Token(type: TokenType.StringOperator, value: string!)
        }
        
        // Must be a variable
        return Token(type: TokenType.Variable, value: string!)
    }
}
