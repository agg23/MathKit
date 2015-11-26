//
//  Result.swift
//  MathKit
//
//  Created by Adam Gastineau on 11/26/15.
//  Copyright © 2015 Adam Gastineau. All rights reserved.
//

import Foundation

class ResultToken: Token {
    var error: String
    
    init(errorMessage: String) {
        self.error = errorMessage
        super.init(type: TokenType.Result, value: "")
    }
    
    init(token: Token) {
        self.error = ""
        super.init(type: TokenType.Result, value: token.value)
    }
    
    init(decimal: Double) {
        self.error = ""
        super.init(type: TokenType.Result, value: NSNumber(double: decimal))
    }
}