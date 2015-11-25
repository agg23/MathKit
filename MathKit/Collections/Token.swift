//
//  Token.swift
//  MathKit
//
//  Created by Adam Gastineau on 11/24/15.
//  Copyright © 2015 Adam Gastineau. All rights reserved.
//

import Foundation

enum TokenType {
    // Operator represents standard operators, such as +, -, and ()
    // StringOperator represents string based operators, such as sin(x) and sqrt(x)
    case Operator, StringOperator, Decimal, Variable
}

class Token: NSObject {
    var type: TokenType
    var value: AnyObject
    
    init(type: TokenType, value: AnyObject) {
        self.type = type
        self.value = value
    }
}
